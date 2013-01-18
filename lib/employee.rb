require File.expand_path(File.dirname(__FILE__)) + '/user'

class Employee < User
  def percent_discount
    30
  end
end
