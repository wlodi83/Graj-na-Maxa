class CreateCategoriesGames < ActiveRecord::Migration
  def self.up
    create_table :categories_games, :id => false do |t|
      t.references :category
      t.references :game
    end
  end

  def self.down
    drop_table :categories_games
  end
end
