require "test/unit"
require "date"
require File.expand_path(File.dirname(__FILE__)) + "/kabill"


class TestCashier < Test::Unit::TestCase
  BILL_AMOUNT = 990
  EMPLOYEE_DISCOUNT = 297
  AFFILIATE_DISCOUNT = 99
  LOYALTY_DISCOUNT = 49.5
  SURE_SHOT_DISCOUNTED_PRICE = BILL_AMOUNT - 45 
  
  def test_normal_user_discount
    user = User.new
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE, Cashier.discount(user, BILL_AMOUNT))
  end

  def test_employee_discount
    employee = Employee.new
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE - EMPLOYEE_DISCOUNT , Cashier.discount(employee, BILL_AMOUNT))
  end

  def test_affiliate_discount
    affiliate = Affiliate.new
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE - AFFILIATE_DISCOUNT, Cashier.discount(affiliate, BILL_AMOUNT))
  end

  def test_loyal_customer_discount
    loyal_user = User.new
    loyal_user.since = DateTime.now << 24
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE - LOYALTY_DISCOUNT, Cashier.discount(loyal_user, BILL_AMOUNT))
  end

  def test_sureshot_discount_with_a_float
    user = User.new
    assert_equal(990.5 - 45, Cashier.discount(user, 990.5))
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
