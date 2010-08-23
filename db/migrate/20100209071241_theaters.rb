class Theaters < ActiveRecord::Migration
  def self.up
    create_table :theaters do |t|
      t.string :name
      t.text :location
    end
  end

  def self.down
    drop_table :theaters
  end
end
