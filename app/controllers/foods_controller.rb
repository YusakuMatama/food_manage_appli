class FoodsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
    @japanese_foods = Food.where(menu_id: 1)
    @western_foods = Food.where(menu_id: 2)
    @chinese_foods = Food.where(menu_id: 3)
    @fast_foods = Food.where(menu_id: 4)
    @drinks = Food.where(menu_id: 5)
    @other_foods = Food.where(menu_id: 6)
    @otumamis = Food.where(menu_id: 7)
    @snacks = Food.where(menu_id: 8)
    @sweets = Food.where(menu_id: 9)
    @pans = Food.where(menu_id: 10)
  end



end
