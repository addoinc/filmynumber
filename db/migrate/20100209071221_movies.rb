class Movies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.string :genre
      t.text :cast
    end
  end
  
  def self.down
    drop_table :movies
  end
end
