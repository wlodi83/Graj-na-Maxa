class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :title
      t.text :description
      t.text :instruction
      t.string :embed_src
      t.integer :author_id
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
