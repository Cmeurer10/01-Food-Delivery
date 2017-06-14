require_relative "../models/meal.rb"
require_relative "../views/view.rb"

class MealsController
  attr_reader :meal_repository

  def initialize(meal_repo)
    @meal_repository = meal_repo
  end

  def list
    @meal_repository.all.each do |meal|
      View.display("#{meal.id}: #{meal.name}: $#{meal.price}")
    end
  end

  def delete
    list
    View.query('meal entry to delete (by id)')
    meal_id = gets.chomp.to_i
    View.display('This meal does not exist!') unless @meal_repository.find(meal_id)
    @meal_repository.delete(meal_id)
  end

  def add
    print "What is the meal name? "
    meal_name = gets.chomp
    print "What is the price ($)? "
    price = gets.chomp.to_i
    @meal_repository.add(Meal.new(name: meal_name, price: price))
  end
end
