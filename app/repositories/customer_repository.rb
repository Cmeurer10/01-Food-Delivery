require 'csv'
require_relative '../models/customer.rb'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    csv_read if File.exist?(csv_file_path)
  end

  def all
    @customers
  end

  def add(new_customer)
    next_id = @customers.empty? ? 1 : (@customers.last.id + 1)
    new_customer.id = next_id
    @customers << new_customer
    csv_write if @csv_file_path
  end

  def find(id)
    @customers.find { |ele| ele.id == id }
  end

  def delete(customer_id)
    @customers.delete(find(customer_id)) if find(customer_id)
    csv_write
  end

  private

  def csv_read
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
  end

  def csv_write
    csv_options = { col_sep: ',' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        csv << [customer.id.to_s, customer.name, customer.address]
      end
    end
  end
end
