require_relative 'customer_repository.rb'
require_relative 'employee_repository.rb'
require_relative 'meal_repository.rb'
require 'csv'
require_relative '../models/order.rb'


class OrderRepository

  attr_reader :orders

  def initialize(csv_file_path, meal_repo, employee_repo, customer_repo)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repo
    @employee_repository = employee_repo
    @customer_repository = customer_repo
    @orders = []
    csv_read if File.exist?(@csv_file_path)
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def deliver!(order)
    order.deliver!
    csv_write
  end

  def add(new_order)
    next_id = @orders.empty? ? 1 : (@orders.last.id + 1)
    new_order.id = next_id
    @orders << new_order
    csv_write if @csv_file_path
  end

  private

  def csv_read
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      @orders << Order.new(row)
    end
  end

  def csv_write
    csv_options = { col_sep: ',' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ["id", "delivered", "meal_id", "employee_id", "customer_id"]
      @orders.each do |order|
        csv << [order.id.to_s, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end
end
