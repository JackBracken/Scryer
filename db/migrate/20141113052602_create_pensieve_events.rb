class CreatePensieveEvents < ActiveRecord::Migration
  def change
    create_table :pensieve_events do |t|
      t.integer :event_id
      t.string :event_name
      t.string :url
      t.string :ip
      t.string :user_agent
      t.integer :user_id
      t.integer :story_id
      t.string :story_name
      t.integer :author_id
      t.string :author_name
      t.integer :chapter_id
      t.integer :chapter_name
      t.integer :chapter_wordcount
      t.datetime :page_load
      t.datetime :page_start
      t.datetime :page_exit
      t.text :raw_event

      t.timestamps

      t.index :event_name
      t.index [:story_id, :chapter_id]
    end
  end
end
