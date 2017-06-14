require_relative 'app/repositories/meal_repository.rb'
require_relative 'app/controllers/meals_controller.rb'
meals_csv = 'data/meals.csv'
meal_repo = MealRepository.new(meals_csv)
meals_ctlr = MealsController.new(meal_repo)

require_relative 'app/repositories/customer_repository.rb'
require_relative 'app/controllers/customers_controller.rb'
customers_csv = 'data/customers.csv'
customer_repo = CustomerRepository.new(customers_csv)
customers_ctlr = CustomersController.new(customer_repo)

require_relative 'app/repositories/employee_repository.rb'
require_relative 'app/controllers/sessions_controller.rb'
employees_csv = 'data/employees.csv'
employee_repo = EmployeeRepository.new(employees_csv)
sessions_ctlr = SessionsController.new(employee_repo)

require_relative 'app/repositories/order_repository.rb'
require_relative 'app/controllers/orders_controller.rb'
orders_csv = 'data/orders.csv'
order_repo = OrderRepository.new(orders_csv, meal_repo, employee_repo, customer_repo)
orders_ctlr = OrdersController.new(meals_ctlr, sessions_ctlr, customers_ctlr, order_repo)

require_relative 'router.rb'
router = Router.new(meals_ctlr, sessions_ctlr, customers_ctlr, orders_ctlr)

router.run
