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
