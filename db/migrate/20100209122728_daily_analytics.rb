class DailyAnalytics < ActiveRecord::Migration
  def self.up
    create_table :daily_analytics do |t|
      t.integer :movie_id
      t.string :movie_name
      t.datetime :run_date
      t.integer :show_count
      t.column :show_percent, :double
    end
  end
  
  def self.down
    drop_table :daily_analytics
  end
end
