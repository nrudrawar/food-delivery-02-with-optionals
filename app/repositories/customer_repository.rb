require_relative "base_repository"
require_relative "../models/customer"

class CustomerRepository < BaseRepository
  def update(index, name, address)
    element = @elements[index]
    element.name = name
    element.address = address
    save_csv
  end

  private

  def build_headers
    %w[id name address]
  end

  def build_row(element)
    [element.id, element.name, element.address]
  end

  def build_element(row)
    Customer.new(row)
  end
end
