class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name

      t.timestamps
    end
  end
end
