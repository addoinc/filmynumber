require File.dirname(__FILE__) + '/../test_helper'

class MovieTest < ActiveSupport::TestCase
  should_have_many :shows
  should_have_many :theaters, :through => :shows
  should_validate_presence_of :name
end
