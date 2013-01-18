require File.expand_path(File.dirname(__FILE__)) + '/item'

class GroceryItem < Item
  def discounted?
    false
  end
end
