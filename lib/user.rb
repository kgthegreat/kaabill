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
