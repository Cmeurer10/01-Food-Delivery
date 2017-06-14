require_relative "../models/customer.rb"
require_relative "../views/view.rb"

class CustomersController
  attr_reader :customer_repository

  def initialize(customer_repo)
    @customer_repository = customer_repo
  end

  def list
    @customer_repository.all.each do |customer|
      View.display("#{customer.id}: #{customer.name}, #{customer.address}")
    end
  end

  def delete
    list
    View.query('customer entry to delete (by id)')
    customer_id = gets.chomp.to_i
    View.display('This customer does not exist!') unless @customer_repository.find(customer_id)
    @customer_repository.delete(customer_id)
  end


  def add
    print "What is the customer's name? "
    customer_name = gets.chomp
    print "What is the customer's address? "
    customer_address = gets.chomp
    @customer_repository.add(Customer.new(name: customer_name, address: customer_address))
  end
end
