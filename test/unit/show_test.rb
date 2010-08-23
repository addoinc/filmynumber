require File.dirname(__FILE__) + '/../test_helper'

class ShowTest < ActiveSupport::TestCase
  should_belong_to :theater
  should_belong_to :movie
  should_validate_presence_of :start
end
