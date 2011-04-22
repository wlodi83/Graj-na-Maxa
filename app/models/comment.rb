class Comment < ActiveRecord::Base
  belongs_to :game
  
  validates :name, :email, :body, :presence => true
  validate :game_should_be_published
  
  def game_should_be_published
    errors.add(:game_id, "is not published yet") if game && !game.published?
  end
end
