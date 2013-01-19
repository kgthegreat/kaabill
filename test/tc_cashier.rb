require "test/unit"
require "date"
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

class TestCashier < Test::Unit::TestCase
  BILL_AMOUNT                = 990
  EMPLOYEE_DISCOUNT          = 297
  AFFILIATE_DISCOUNT         = 99
  LOYALTY_DISCOUNT           = 49.5

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
    assert_equal( 25 + 35 + 550 - 30, Cashier.prepare_bill(user, items))
  end

  def test_cashier_correctly_bills_a_customer_with_only_groceries
    user = User.new
    items = [@rice, @wheat, @cornflakes]
    assert_equal( 550 + 750 + 800 - 105, Cashier.prepare_bill(user, items))
  end
  
  def test_cashier_correctly_bills_an_employee_with_some_groceries
    employee = Employee.new
    items = [@wallet, @chair, @rice]
    assert_equal( 500 + 490 + 550 - 297 - 15*5, Cashier.prepare_bill(employee, items))
  end

  def test_cashier_correctly_bills_an_affiliate_with_some_groceries
    affiliate = Affiliate.new
    items = [@wallet, @pen, @cornflakes]
    assert_equal(  1216.5, Cashier.prepare_bill(affiliate, items))
  end

  def test_normal_customer_percent_discount
    user = User.new
    assert_equal(0, Cashier.percent_based_discount(user, BILL_AMOUNT))
  end

  def test_employee_percent_discount
    employee = Employee.new
    assert_equal(EMPLOYEE_DISCOUNT , Cashier.percent_based_discount(employee, BILL_AMOUNT))
  end

  def test_affiliate_discount
    affiliate = Affiliate.new
    assert_equal(AFFILIATE_DISCOUNT, Cashier.percent_based_discount(affiliate, BILL_AMOUNT))
  end

  def test_loyal_customer_discount
    loyal_user = User.new
    loyal_user.since = DateTime.now << 24
    assert_equal(LOYALTY_DISCOUNT, Cashier.percent_based_discount(loyal_user, BILL_AMOUNT))
  end

  def test_employee_percent_discount_with_a_float
    employee = Employee.new
    assert_equal(297.15, Cashier.percent_based_discount(employee, 990.5))
  end

  def test_sureshot_discount
    assert_equal(45, Cashier.sureshot_discount(990))
    assert_equal(25, Cashier.sureshot_discount(500))
    assert_equal(75, Cashier.sureshot_discount(1540))
    assert_equal(75, Cashier.sureshot_discount(1500))
    assert_equal(70, Cashier.sureshot_discount(1499))
    assert_equal(70, Cashier.sureshot_discount(1499.99))
    assert_equal(25, Cashier.sureshot_discount(510.67))
  end

  def test_method_returns_only_the_price_total_for_discounted_items
    items = [@rice, @wheat, @cornflakes]
    assert_equal(0, Cashier.find_total_percent_discounted_price(items))
    items = [@pen, @wallet, @cornflakes]
    assert_equal(@pen.price + @wallet.price, Cashier.find_total_percent_discounted_price(items))
    items = [@pen, @wallet]
    assert_equal(@pen.price + @wallet.price, Cashier.find_total_percent_discounted_price(items))
  end

  def test_method_returns_only_the_price_total_for_non_discounted_items
    items = [@rice, @wheat, @cornflakes]
    assert_equal(@rice.price+@wheat.price+@cornflakes.price, Cashier.find_total_non_percent_discounted_price(items))
    items = [@pen, @wallet, @cornflakes]
    assert_equal(@cornflakes.price, Cashier.find_total_non_percent_discounted_price(items))
    items = [@pen, @wallet]
    assert_equal(0, Cashier.find_total_non_percent_discounted_price(items))
  end

end
