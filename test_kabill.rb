require "test/unit"
require "date"
require File.expand_path(File.dirname(__FILE__)) + "/kabill"


class TestCashier < Test::Unit::TestCase
  def test_normal_user_discount
    user = User.new
    assert_equal(1000, Cashier.discount(user, 1000))
  end

  def test_employee_discount
    employee = Employee.new
    bill_amount = 1000
    expected_discounted_amount = 1000 - 1000 * 30/100
    assert_equal(expected_discounted_amount, Cashier.discount(employee, bill_amount))
  end

  def test_affiliate_discount
    affiliate = Affiliate.new
    bill_amount = 1000
    expected_discounted_amount = 1000 - 1000 * 10/100
    assert_equal(expected_discounted_amount, Cashier.discount(affiliate, bill_amount))
  end

  def test_loyal_customer_discount
    loyal_user = User.new
    loyal_user.since = DateTime.now << 24
    bill_amount = 1000
    expected_discounted_amount = 1000 - 1000 * 5/100
    assert_equal(expected_discounted_amount, Cashier.discount(loyal_user, bill_amount))
  end

end

class TestUser < Test::Unit::TestCase
  def test_percent_discount
    assert_equal(0,User.new.percent_discount)
  end
end
class TestEmployee < Test::Unit::TestCase
  def test_percent_discount
    assert_equal(30,Employee.new.percent_discount)
  end
end
class TestAffiliate < Test::Unit::TestCase
  def test_percent_discount
    assert_equal(10,Affiliate.new.percent_discount)
  end

  def test_loyal_percent_discount
    loyal_user = User.new
    loyal_user.since = DateTime.now << 24
    assert_equal(5,loyal_user.percent_discount)
  end
end
