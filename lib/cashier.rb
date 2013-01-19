class Cashier
  def self.prepare_bill(user, items)
    percent_discount_applicable_amount = find_total_percent_discounted_price(items)
    no_percent_discount_applicable_amount = find_total_non_percent_discounted_price(items)

    net = percent_discount_applicable_amount + no_percent_discount_applicable_amount 
    net_payable = net - percent_based_discount(user, percent_discount_applicable_amount) - sureshot_discount(net)
    net_payable.round(2)
  end
  
  def self.percent_based_discount(user, amount)
    amount * user.percent_discount/100.0
  end

  def self.sureshot_discount(amount)
    amount.truncate/100 * 5
  end

  def self.find_total_percent_discounted_price(items)
    total = 0
    items.select {|item| item.discounted? }.each do |item|
      total = total + item.price
    end
    total
  end

  def self.find_total_non_percent_discounted_price(items)
    total = 0
    items.select {|item| !item.discounted? }.each do |item|
      total = total + item.price
    end
    total
  end

end
