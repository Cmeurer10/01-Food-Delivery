class Employee
  attr_reader :username, :password, :role
  attr_accessor :id

  def initialize(attributes = {})
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
    @id = attributes[:id]
  end

  def manager?
    #   should return true is the employee is a manager (FAILED - 54)
    #   should return false is the employee is a delivery guy (FAILED - 55)
    @role == 'manager'
  end

  def delivery_guy?
    #   should return true is the employee is a delivery guy (FAILED - 56)
    #   should return false is the employee is a manager (FAILED - 57)
    @role == 'delivery_guy'
  end
end
