require 'csv'
require_relative '../models/meal.rb'
require 'pry-byebug'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    # binding.pry
    csv_read if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def add(new_meal)
    next_id = @meals.empty? ? 1 : (@meals.last.id + 1)
    new_meal.id = next_id
    @meals << new_meal
    csv_write if @csv_file_path
  end

  def find(id)
    @meals.find { |ele| ele.id == id }
  end

  def delete(meal_id)
    @meals.delete(find(meal_id)) if find(meal_id)
    csv_write
  end

  private

  def csv_read
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
  end

  def csv_write
    csv_options = { col_sep: ',' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id.to_s, meal.name, meal.price.to_s]
      end
    end
  end
end
