class Game < ActiveRecord::Base
  self.per_page = 5
  before_save :update_published_at
  attr_accessible :title, :instruction, :description, :embed_src, :category_ids, :published_at, :photos_attributes, :published, :tag_list
  acts_as_taggable_on :tags
  belongs_to :age_bracket
  belongs_to :author
  belongs_to :user
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  has_and_belongs_to_many :categories
  has_many :comments
  has_many :photos
  accepts_nested_attributes_for :photos, :allow_destroy => true  
  scope :published, where("games.published_at IS NOT NULL")
  scope :draft, where("games.published_at IS NULL")
  scope :recent, lambda { published.where("games.published_at > ?", 1.week.ago.to_date)}
  scope :where_title, lambda { |term| where("games.title LIKE ?", "%#{term}%") }
  # redis
  def self.set_hits_counter(game_id)
   begin
   $redis.ping
   rescue Errno::ECONNREFUSED
   else
   $redis.set "game_counter_hits_#{game_id}", 0
   end 
  end
  def self.increase_hits_counter(game_id)
   begin
   $redis.ping
   rescue Errno::ECONNREFUSED
   else
   $redis.incr "game_counter_hits_#{game_id}"
   end
  end
  def self.current_counter_hits(game_id)
   begin
   $redis.ping
   rescue Errno::ECONNREFUSED
   else
   $redis["game_counter_hits_#{game_id}"]
   end
  end

  def most_viewed_game
    begin
    $redis.ping
    rescue Errno::ECONNREFUSED
    else
     hash_list = Hash.new
     Game.each do |game|
     hash_list[game.id] = Game.current_counter_hits(game.id)
     end
     hash_list.keys.sort {|a,b| a[1] <=> b[1]}[0..4].reverse.each do |game|
     Game.find(game)
     end
    end
  end
  # thinking_sphinx
  define_index do
    indexes title
    #indexes author
    #indexes age
    indexes instruction
    indexes description
    indexes user.email, :as => :user_email
    indexes categories.name, :as => :categories_name
  
    has user(:id), :as => :user_ids
    #has author(:id), :as => :author_ids
    has categories(:id), :as => :category_ids
    
    has created_at, updated_at, published_at 
  end 
  validates :title, :presence => true,
	            :uniqueness => true
  validates :description, :presence => true
  validates :instruction, :presence => true
  validates :embed_src, :presence => true
  def average_rating
    @value = 0
    self.ratings.each do |rating|
      @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f 
  end
 
  def update_published_at
    self.published_at = Time.now if published == true  
  end
  def published?
    published_at.present?
  end

  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
