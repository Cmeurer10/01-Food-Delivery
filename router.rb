require_relative 'app/views/view.rb'
require 'pry-byebug'

class Router

  def initialize(meals_ctlr, sessions_ctlr, customers_ctlr, orders_ctlr)
    @meals_ctlr = meals_ctlr
    @sessions_ctlr = sessions_ctlr
    @customers_ctlr = customers_ctlr
    @orders_ctlr = orders_ctlr
    @user = nil
  end

  def run
    View.clear
    @user = @sessions_ctlr.sign_in
    if @user.role == 'delivery_guy'
      delivery_guy(@user)
    elsif @user.role == 'manager'
      manager
    else
      View.display('This employee has not been assigned a role')
    end
    View.clear
  end

  private

  def manager
    action = nil
    until action == 9
      action = nil
      until (action.respond_to?'to_i') && ((1..9).include? action.to_i)
        View.manager_actions
        action = gets.chomp.to_i
        View.clear
      end
      manager_actions(action)
      View.newline
    end
  end

  def delivery_guy(employee)
    action = nil
    until action == 3
      action = nil
      until (action.respond_to?'to_i') && ((1..3).include? action.to_i)
        View.delivery_guy_actions
        action = gets.chomp.to_i
        View.clear
      end
      delivery_guy_actions(action, employee)
      View.newline
    end
  end

  def manager_actions(action)
    case action
      when 1; @meals_ctlr.add
      when 2; @meals_ctlr.list
      when 3; @customers_ctlr.add
      when 4; @customers_ctlr.list
      when 5; @orders_ctlr.list_undelivered_orders
      when 6; @orders_ctlr.add
      when 7; @meals_ctlr.delete
      when 8; @customers_ctlr.delete
    end
  end

  def delivery_guy_actions(action, employee)
    case action
      when 1; @orders_ctlr.list_my_orders(employee)
      when 2; @orders_ctlr.mark_as_delivered
    end
  end
end
