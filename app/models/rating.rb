class Rating < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to :game
  belongs_to :user
end
