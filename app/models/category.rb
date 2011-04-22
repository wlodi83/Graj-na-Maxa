class Category < ActiveRecord::Base
  has_and_belongs_to_many :games
  has_and_belongs_to_many :users
  acts_as_tree :order => "name"
  default_scope order('categories.name')
end
