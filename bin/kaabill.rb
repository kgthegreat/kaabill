require 'date'
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

def terminal
  puts "=========================== Welcome to kaaBILL =================================="
  inventory = build_inventory
  items = get_items_bought_out_of(inventory)
  customer = get_customer_profile
  produce_bill(customer, items)
end

# Add or edit products here
def build_inventory
  wallet = Item.new("wallet", 500)
  chair = Item.new("chair", 490.45)
  pen = Item.new("pen", 35)
  notebook = Item.new("notebook", 25)
  rice = GroceryItem.new("rice", 550)
  wheat = GroceryItem.new("wheat", 750.99)
  cornflakes = GroceryItem.new("cornflakes", 800.99)
  [wallet, chair, pen, notebook, rice, wheat, cornflakes]  
end  

def get_items_bought_out_of(inventory)
  pretty_print("Customer Purchased What?")
  inventory.each_with_index { |item, i| puts (i+1).to_s + "." + item.name + "  $#{item.price}" }
  puts "Enter your answer comma separated, eg. 2,3"
  bought = gets.chomp
  items = []
  bought.split(",").each do |index|
    item = inventory[index.to_i-1]
    if index.to_i == 0 ||item.nil?
      warning_print("Your input #{index} was in error and hence not considered")
    else
      items << item
    end
  end
  return items
end

def get_customer_profile
  pretty_print("Choose the type of customer")

  user = User.new
  employee = Employee.new
  affiliate = Affiliate.new

  type_of_user = [user, employee, affiliate]
  type_of_user.each_with_index {|user, i| puts (i+1).to_s + "." + user.class.name}
  puts "Enter the number as answer, eg. 1"
  user_index = gets.chomp
  if user_index.to_i == 0 || type_of_user[user_index.to_i-1].nil?
    warning_print("Your input #{user_index} was in error and hence a normal user was taken as default")
    customer = user
  else
    customer = type_of_user[user_index.to_i-1]
  end
  pretty_print("Is customer eligible for loyalty discount?[y/n]")  
  loyal = gets.chomp
  customer.since = DateTime.now << 24 if loyal == 'y'
  return customer
end

def pretty_print(heading)
  puts "---------------------------------------------------------------------------------"
  puts heading
  puts "---------------------------------------------------------------------------------"
end  

def warning_print(heading)
  puts "*********************************************************************************"
  puts heading
    puts "*********************************************************************************"
end  

def produce_bill(customer, items)
  pretty_print "Total amount to be paid"
  puts Cashier.prepare_bill(customer, items)
end

terminal
