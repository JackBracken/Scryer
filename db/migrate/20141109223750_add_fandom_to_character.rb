class AddFandomToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :fandom_id, :integer
  end
end
