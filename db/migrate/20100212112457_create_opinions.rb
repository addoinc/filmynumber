class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.integer :user_id, :null => false
      t.integer :movie_id, :null => false
      t.boolean :seen, :default => false
      t.boolean :watchable, :default => false
      t.boolean :watchable_twice, :default => false
      t.boolean :watchable_multi, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
