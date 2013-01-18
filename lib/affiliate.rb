require File.expand_path(File.dirname(__FILE__)) + '/user'

class Affiliate < User
  def percent_discount
    10
  end
end
