class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :food_set
  
  def index
  end

  def show
  end

  def new
    @new_food = Food.new

    @menu = Menu.all

    @japanese_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 1}).map { |h| h[:name] }
    @western_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 2}).map { |h| h[:name] }
    @chinese_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 3}).map { |h| h[:name] }
    @fast_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 4}).map { |h| h[:name] }
    @drinks_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 5}).map { |h| h[:name] }
    @other_country_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 6}).map { |h| h[:name] }
    @otumamis_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 7}).map { |h| h[:name] }
    @snacks_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 8}).map { |h| h[:name] }
    @sweets_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 9}).map { |h| h[:name] }
    @pans_category = MenuCategory.eager_load(:foods).where(foods: {menu_id: 10}).map { |h| h[:name] }

    gon.japanese = @japanese_category
    gon.western = @western_category
    gon.chinese = @chinese_category
    gon.fast = @fast_category
    gon.drinks = @drinks_category
    gon.other_country = @other_country_category
    gon.otumamis = @otumamis_category
    gon.snacks = @snacks_category
    gon.sweets = @sweets_category
    gon.pans = @pans_category

  end

  def create
    @new_food = Food.new(food_params)

    if @new_food.save
      redirect_to "/"
    end
  end

private
  def food_set
    @japanese_foods = Food.where(menu_id: 1)
    @western_foods = Food.where(menu_id: 2)
    @chinese_foods = Food.where(menu_id: 3)
    @fast_foods = Food.where(menu_id: 4)
    @drinks = Food.where(menu_id: 5)
    @other_country_foods = Food.where(menu_id: 6)
    @otumamis = Food.where(menu_id: 7)
    @snacks = Food.where(menu_id: 8)
    @sweets = Food.where(menu_id: 9)
    @pans = Food.where(menu_id: 10)
  end

  def search_menu_and_menu_category
    @menu = params.require(:food).permit(:menu_id)
    @menu = Menu.find_by(name: @menu["menu_id"])

    @menu_category = params.require(:food).permit(:menu_category_id)
    @menu_category = MenuCategory.find_by(name: @menu_category["menu_category_id"])
  end

  def food_params
    search_menu_and_menu_category
    params.require(:food).permit(:name, :hiragana_name, :calorie).merge(menu_id: @menu.id, menu_category_id: @menu_category.id)
  end
end
