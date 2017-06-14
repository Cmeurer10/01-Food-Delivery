class Order
  attr_accessor :id, :meal, :employee, :customer

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    return @delivered
  end

  def deliver!
    @delivered = true
    self
  end
end
