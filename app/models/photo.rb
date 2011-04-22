class Photo < ActiveRecord::Base
  belongs_to :game
  has_attached_file :photo, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" }
end
