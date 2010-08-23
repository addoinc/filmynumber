class DailyAnalytics < ActiveRecord::Base
  set_table_name "daily_analytics"
  belongs_to :movie

  named_scope :most_viewable, lambda {  }
end
