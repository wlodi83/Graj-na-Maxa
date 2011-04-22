class AddPublishedToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :published, :boolean, :default => false
  end

  def self.down
    remove_column :games, :published
  end
end
