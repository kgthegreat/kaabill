require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/../lib/user"

class TC_User < Test::Unit::TestCase
  def test_percent_discount
    assert_equal(0,User.new.percent_discount)
  end
end
