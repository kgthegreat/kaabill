=begin
On a retail website, the following discounts apply:
1. If the user is an employee of the store, he gets a 30% discount
2. If the user is an affiliate of the store, he gets a 10% discount
3. If the user has been a customer for over 2 years, he gets a 5% discount.
4. For every $100 on the bill, there would be a $ 5 discount (e.g. for $ 990, you get $ 45 as a discount).
5. The percentage based discounts do not apply on groceries.
6. A user can get only one of the percentage based discounts on a bill.
Write a program with test cases such that given a bill, it finds the net payable amount. Please note the stress is on object oriented approach and test coverage.

> object oriented programming approach 
> test coverage 
> making sure the code is correctly uploaded on github 
> code to be generic and simple 
> leverage today's best coding practices

User
- first_purchase
Employee
Affiliate
Purchase - groceries

=end

require "date"
class Cashier
  def self.prepare_bill(user, items)
    total_to_be_discounted = 0;
    total_to_be_not_discounted = 0;
    items.select {|item| item.discounted? }.each do |item|
      total_to_be_discounted = total_to_be_discounted + item.price
    end
    items.select {|item| !item.discounted? }.each do |item|
      total_to_be_not_discounted = total_to_be_not_discounted + item.price
    end
    
    net_amount_payable = apply_discount(user, total_to_be_discounted) + total_to_be_not_discounted
  end
  
  def self.apply_discount(user, bill_amount)
    bill_amount - bill_amount * user.percent_discount/100.0 - bill_amount.truncate/100 * 5
  end
end

class User
  attr_accessor :since
  def percent_discount
    if @since && @since <= DateTime.now << 24
      5
    else
      0
    end
  end
end

class Employee < User
  def percent_discount
    30
  end
end

class Affiliate < User
  def percent_discount
    10
  end
end

class Item
  attr_accessor :price
  def initialize(price)
    @price = price
  end
  def discounted?
    true
  end
end

class GroceryItem < Item
  def discounted?
    false
  end
end

