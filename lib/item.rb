class Item
  attr_accessor :price
  attr_accessor :name
  def initialize(name, price)
    @name = name
    @price = price
  end
  def discounted?
    true
  end
end
