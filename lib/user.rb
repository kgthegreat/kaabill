class User
  attr_accessor :since
  def percent_discount
    if eligible_for_loyalty_discount?
      5
    else
      0
    end
  end
  def eligible_for_loyalty_discount?
    @since && @since <= DateTime.now << 24
  end
end
