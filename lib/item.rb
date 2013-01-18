class Item
  attr_accessor :price
  def initialize(price)
    @price = price
  end
  def discounted?
    true
  end
end
