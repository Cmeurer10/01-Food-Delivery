require_relative "../views/view.rb"

class SessionsController
  attr_reader :employee_repository

  def initialize(employee_repository)
    @employee_repository = employee_repository
  end

  def list
    @employee_repository.all.each do |employee|
      View.display("#{employee.id}: #{employee.username}, #{employee.role}")
    end
  end

  def sign_in
    loop do
      View.display('username')
      username = gets.chomp
      View.display('password')
      password = gets.chomp
      user = @employee_repository.find_by_username(username)
      View.display('welcome') if user && user.password == password
      return user if user && user.password == password
      View.display("wrong credentials") unless user && user.password == password
    end
  end
end
