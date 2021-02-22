class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          route_manager_action
        else
          route_delivery_guy_action
        end
      end
      print `clear`
    end
  end

  private

  def route_manager_action
    print_manager_menu
    choice = gets.chomp.to_i
    print `clear`
    manager_action(choice)
  end

  def route_delivery_guy_action
    print_delivery_guy_menu
    choice = gets.chomp.to_i
    print `clear`
    delivery_guy_action(choice)
  end

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Edit a meal"
    puts "4. Delete a meal"
    puts "5. Add new customer"
    puts "6. List all customers"
    puts "7. Edit a customer"
    puts "8. Delete a customer"
    puts "9. Add new order"
    puts "10. List all undelivered orders"
    puts "11. Edit an undelivered order"
    puts "12. Delete an undelivered order"
    common_menu
  end

  def print_delivery_guy_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    common_menu
  end

  def common_menu
    puts "13. Logout"
    puts "14. Exit"
    print "> "
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @meals_controller.edit
    when 4 then @meals_controller.delete
    when 5 then @customers_controller.add
    when 6 then @customers_controller.list
    when 7 then @customers_controller.edit
    when 8 then @customers_controller.delete
    when 9 then @orders_controller.add
    when 10 then @orders_controller.list_undelivered_orders
    when 11 then @orders_controller.edit
    when 12 then @orders_controller.delete
    when 13 then logout!
    when 14 then stop!
    else puts "Try again..."
    end
  end

  def delivery_guy_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 12 then logout!
    when 13 then stop!
    else puts "Try again..."
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
