require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/../lib/employee"

class TC_Employee < Test::Unit::TestCase
  def test_percent_discount
    assert_equal(30,Employee.new.percent_discount)
  end
end
