module Moysklad::Entities
  class CustomerOrderPosition < Base
    attribute :quantity, Integer
    attribute :price, Integer
    attribute :discount, Integer
    attribute :vat, Integer
    attribute :reserve, Integer
    attribute :assortment, Assortment
  end
end
