require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/discounter"


class TestDiscounter < Test::Unit::TestCase
  def test_cashier_returns_discounted_amount_as_total_bill_if_user_does_not_qualify_for_discount
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
end

