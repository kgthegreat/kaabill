require "test/unit"
require "date"
require File.expand_path(File.dirname(__FILE__)) + "/../lib/cashier"


class TestCashier < Test::Unit::TestCase
  BILL_AMOUNT                = 990
  EMPLOYEE_DISCOUNT          = 297
  AFFILIATE_DISCOUNT         = 99
  LOYALTY_DISCOUNT           = 49.5
  SURE_SHOT_DISCOUNTED_PRICE = BILL_AMOUNT - 45 

  def setup
    @wallet = Item.new("wallet", 500)
    @chair = Item.new("chair", 490)
    @pen = Item.new("pen", 35)
    @notebook = Item.new("notebook", 25)
    @rice = GroceryItem.new("rice", 550)
    @wheat = GroceryItem.new("wheat", 750)
    @cornflakes = GroceryItem.new("cornflakes", 800)
  end
  
  def test_cashier_correctly_bills_a_customer_with_no_groceries
    user = User.new
    items = [@wallet, @chair]
    assert_equal(990 - 45, Cashier.prepare_bill(user, items))
  end

  def test_cashier_correctly_bills_a_customer_with_some_groceries
    user = User.new
    items = [@pen, @notebook, @rice]
    assert_equal( 25 + 35 + 550, Cashier.prepare_bill(user, items))
  end

  def test_cashier_correctly_bills_a_customer_with_only_groceries
    user = User.new
    items = [@rice, @wheat, @cornflakes]
    assert_equal( 550 + 750 + 800, Cashier.prepare_bill(user, items))
  end
  
  def test_cashier_correctly_bills_an_employee_with_some_groceries
    employee = Employee.new
    items = [@wallet, @chair, @rice]
    assert_equal( SURE_SHOT_DISCOUNTED_PRICE - EMPLOYEE_DISCOUNT + 550, Cashier.prepare_bill(employee, items))
  end

  def test_normal_customer_discount
    user = User.new
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE, Cashier.apply_discount(user, BILL_AMOUNT))
  end

  def test_employee_discount
    employee = Employee.new
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE - EMPLOYEE_DISCOUNT , Cashier.apply_discount(employee, BILL_AMOUNT))
  end

  def test_affiliate_discount
    affiliate = Affiliate.new
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE - AFFILIATE_DISCOUNT, Cashier.apply_discount(affiliate, BILL_AMOUNT))
  end

  def test_loyal_customer_discount
    loyal_user = User.new
    loyal_user.since = DateTime.now << 24
    assert_equal(SURE_SHOT_DISCOUNTED_PRICE - LOYALTY_DISCOUNT, Cashier.apply_discount(loyal_user, BILL_AMOUNT))
  end

  def test_sureshot_discount_with_a_float
    user = User.new
    assert_equal(990.5 - 45, Cashier.apply_discount(user, 990.5))
  end
end
