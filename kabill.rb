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
  def self.discount(user, bill_amount)
    bill_amount - bill_amount * user.percent_discount/100
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
