require_relative "../models/order.rb"
require_relative "../views/view.rb"

class OrdersController

  attr_reader :order_repository

  def initialize(meals_ctlr, sessions_ctlr, customers_ctlr, order_repo)
    @meals_ctlr = meals_ctlr
    @meal_repository = meals_ctlr.meal_repository
    @sessions_ctlr = sessions_ctlr
    @employee_repository = sessions_ctlr.employee_repository
    @customers_ctlr = customers_ctlr
    @customer_repository = customers_ctlr.customer_repository
    @order_repository = order_repo
  end

  def list_undelivered_orders
    @order_repository.undelivered_orders.each do |order|
      View.undelivered_message(order)
    end
  end

  def add
    @meals_ctlr.list
    View.query('meal id')
    meal = @meal_repository.find(gets.chomp.to_i)
    @customers_ctlr.list
    View.query('customer id')
    customer = @customer_repository.find(gets.chomp.to_i)
    @sessions_ctlr.list
    View.query('employee id')
    employee = @employee_repository.find(gets.chomp.to_i)
    @order_repository.add(Order.new(meal: meal, employee: employee, customer: customer))
  end

  def list_my_orders(employee)
    @order_repository.undelivered_orders.each do |order|
      View.undelivered_message(order) if order.employee == employee
    end
  end

  def mark_as_delivered(employee)
    View.query('order id')
    order_id = gets.chomp.to_i
    order = @order_repository.undelivered_orders.find { |ele| ele.id == order_id }
    @order_repository.deliver!(order)
  end
end
