require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/../lib/affiliate"
require 'date'

class TC_Affiliate < Test::Unit::TestCase
  def test_percent_discount
    assert_equal(10,Affiliate.new.percent_discount)
  end

  def test_loyal_percent_discount
    loyal_user = User.new
    loyal_user.since = DateTime.now << 24
    assert_equal(5,loyal_user.percent_discount)
  end
end
