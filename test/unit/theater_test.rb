require File.dirname(__FILE__) + '/../test_helper'

class TheaterTest < ActiveSupport::TestCase
  should_have_many :shows
  should_validate_presence_of :name
end
