require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/../lib/grocery_item"

class TC_GroceryItem < Test::Unit::TestCase
  def test_grocery_item_should_not_be_discounted
    item = GroceryItem.new("groc_item", 98)
    assert_equal(false, item.discounted?)
  end
end
