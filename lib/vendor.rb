class Vendor
  attr_reader :name, 
              :inventory

  def initialize(name)
    @name = name    
    @inventory = Hash.new(0)
  end


  def check_stock(item)
    inventory[item]
  end

  def stock(item, amount)
    inventory[item] += amount
  end

  def potential_revenue
    price_amount = {}
    inventory.map do |item, amount|
      price_amount[item.price] = amount
    end
    revenues = price_amount.map do |price, amount|
      price * amount
    end.sum
  end
end