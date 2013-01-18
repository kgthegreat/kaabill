require "test/unit"
require File.expand_path(File.dirname(__FILE__)) + "/../lib/item"

class TC_GroceryItem < Test::Unit::TestCase
  def test_item_should_be_discounted
    item = Item.new(98)
    assert_equal(true, item.discounted?)
  end
end
