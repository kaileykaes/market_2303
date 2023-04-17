class Market
  attr_reader :name, 
              :vendors
  
  def initialize(name)
    @name = name
    @vendors = []
  end  

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory.include?(item)
    end
  end

  # def total_inventory
  #   #vendors have inventories
  #   big_daddy_inventory = Hash.new({:quantity => 0, :vendors => []})
  #   @vendors.map do |vendor|
  #     vendor.inventory.each do |item, amount|
  #       big_daddy_inventory[item] unless big_daddy_inventory.has_key?(item)
  #       big_daddy_inventory[item][:quantity] += amount unless big_daddy_inventory.has_key?(item)
  #       big_daddy_inventory[item][:vendors] << vendor unless big_daddy_inventory[item][:vendors].include?(vendor) 
  #     end
  #   end
  #   big_daddy_inventory
  # end

  def total_inventory  
    errythang = {}
    vendors.map do |vendor|
      vendor.inventory.each do |item, _|
        errythang[item] = {quantity: 0, vendors: []} unless errythang.has_key?(item)
        errythang[item][:quantity] += vendor.inventory[item]
        errythang[item][:vendors] << vendor unless errythang[item][:vendors].include?(vendor) 
      end
    end
    errythang
  end

end