class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name

      t.timestamps
    end
  end
end
