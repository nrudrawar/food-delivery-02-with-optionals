require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def add
    name = @customers_view.ask_user_for(:name)
    address = @customers_view.ask_user_for(:address)
    customer = Customer.new(name: name, address: address)
    @customer_repository.create(customer)
    display_customers
  end

  def list
    display_customers
  end

  def edit
    display_customers
    index = @customers_view.ask_user_for(:index).to_i - 1
    name = @customers_view.ask_user_for(:name)
    address = @customers_view.ask_user_for(:address)
    @customer_repository.update(index, name, address)
    display_customers
  end

  def delete
    display_customers
    index = @customers_view.ask_user_for(:index).to_i - 1
    @customer_repository.destroy(index)
    display_customers
  end

  private

  def display_customers
    customers = @customer_repository.all
    @customers_view.display(customers)
  end
end
