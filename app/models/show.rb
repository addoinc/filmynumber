class Show < ActiveRecord::Base
  belongs_to :theater
  belongs_to :movie
  validates_presence_of :start

  cattr_reader :per_page
  @@per_page = 10
end
