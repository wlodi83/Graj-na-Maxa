class AddAgeBracketIdToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :age_bracket_id, :integer
  end

  def self.down
    remove_column :games, :age_bracket_id
  end
end
