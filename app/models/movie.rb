class Movie < ActiveRecord::Base
  has_many :shows
  has_many :theaters, :through => :shows
  has_many :daily_analytics
  has_many :opinions
  
  validates_presence_of :name
end
