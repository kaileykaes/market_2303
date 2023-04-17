require 'spec_helper'

RSpec.describe Vendor do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@vendor).to be_a Vendor
    end

    it 'has attribues' do 
      expect(@vendor.name).to eq('Rocky Mountain Fresh')
      expect(@vendor.inventory).to eq({})
    end
  end

  describe 'stock' do 
    it '#check_stock' do 
      expect(@vendor.check_stock(@item1)).to eq(0)
    end

    it '#stock' do 
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to eq({@item1 => 30})
      expect(@vendor.check_stock(@item1)).to eq(30)
      @vendor.stock(@item1, 25)
      expect(@vendor.check_stock(@item1)).to eq(55)
    end

    it '#stock more than 1 item' do 
      @vendor.stock(@item1, 30)
      @vendor.stock(@item1, 25)
      @vendor.stock(@item2, 12)
      expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end

  describe 'revenue' do 
    it 'can find potential revenue' do 
      @vendor.stock(@item1, 30)
      @vendor.stock(@item1, 25)
      @vendor.stock(@item2, 12)
      require 'pry'; binding.pry
      expect(@vendor.potential_revenue).to eq(47.25)
    end
  end
end