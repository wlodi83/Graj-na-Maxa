class AddDescriptionToAgeBrackets < ActiveRecord::Migration
  def self.up
    add_column :age_brackets, :description, :text
  end

  def self.down
    remove_column :age_brackets, :description
  end
end
