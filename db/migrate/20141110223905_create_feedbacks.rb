class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedback do |t|
      t.text :feedback_text
      t.integer :score
      t.integer :user_id

      t.timestamps
    end
  end
end
