class View
  def self.query(text)
    puts "What is the #{text}? "
  end

  def self.undelivered_message(order)
    puts "Customer: #{order.customer.name}, Undelivered order: #{order.meal.name}, Employee: #{order.employee.username}"
  end

  def self.display(text)
    puts text.to_s
  end

  def self.manager_actions
    puts "1: Add a new meal"
    puts "2: View all the meals"
    puts "3: Add a customer"
    puts "4: View all the customers"
    puts "5: View all undelivered orders"
    puts "6: Add an order"
    puts "7: Delete a meal"
    puts "8: Delete a customer"
    puts "9: Logout"
    puts "What would you like to do? (Enter a number)"
  end

  def self.delivery_guy_actions
    puts "1: View undelivered orders"
    puts "2: Mark an order as delivered"
    puts "3: Logout"
    puts "What would you like to do? (Enter a number)"
  end

  def self.clear
    puts `clear`
  end

  def self.newline
    puts ''
  end
end
