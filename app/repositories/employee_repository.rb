require 'csv'
require_relative '../models/employee.rb'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = File.exist?(csv_file_path) ? csv_file_path : nil
    @employees = []
    csv_read if @csv_file_path
  end

  def all
    @employees
  end

  def all_delivery_guys
    @employees.select { |ele| ele.role == 'delivery_guy' }
  end

  def find(id)
    @employees.find { |ele| ele.id == id }
  end

  def find_by_username(username)
    @employees.find { |ele| ele.username == username }
  end

  private

  def csv_read
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end
end
