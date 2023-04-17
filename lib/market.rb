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

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, _|
        item.name
      end
    end.uniq.sort
  end

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
  
  def overstocked_items
    too_many_items = []
    total_inventory.each do |item, info|
      too_many_items << item if info[:quantity] > 50 && 
      info[:vendors].length > 1
    end
    too_many_items
  end
end