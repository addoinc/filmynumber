class Shows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.integer :theater_id
      t.integer :movie_id
      t.datetime :start
    end
  end
  
  def self.down
    drop_table :shows
  end
end
