class UsersController < ApplicationController
  # before_action :authenticate_user!

  def index
    gon.data_calorie = []
    gon.data_date = [*(Date.today.beginning_of_week..Date.today.end_of_week)]
    # @user_eat_data = FoodEating.where(user_id: current_user.id)
    @this_week = Date.today.all_week
    total_calorie_1 = 0
    total_calorie_2 = 0
    total_calorie_3 = 0
    total_calorie_4 = 0
    total_calorie_5 = 0
    total_calorie_6 = 0
    total_calorie_7 = 0

      # @user_eat_data.each do |eat_data|
      #   today_eat_time = eat_data[:created_at].in_time_zone('Tokyo')
      #   if (today_eat_time.to_s.match(/#{Date.today.beginning_of_week.to_s}.+/))
      #     total_calorie_1 += eat_data[:calorie].to_i

      #   elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 1).to_s}.+/))
      #     total_calorie_2 += eat_data[:calorie].to_i

      #   elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 2).to_s}.+/))
      #     total_calorie_3 += eat_data[:calorie].to_i

      #   elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 3).to_s}.+/))
      #     total_calorie_4 += eat_data[:calorie].to_i

      #   elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 4).to_s}.+/))
      #     total_calorie_5 += eat_data[:calorie].to_i

      #   elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 5).to_s}.+/))
      #     total_calorie_6 += eat_data[:calorie].to_i

      #   else
      #     total_calorie_7 += eat_data[:calorie].to_i
      #   end        
      # end
      # gon.data_calorie.push(total_calorie_1, total_calorie_2, total_calorie_3, total_calorie_4, total_calorie_5, total_calorie_6, total_calorie_7)
  end

  # def show
  #   @user = User.find(id: current_user.id)
  # end

  # def edit
  #   @user = User.find(id: current_user.id)
  # end
  def new
    @user_status = UserStatus.new
  end

  def create
    @user = User.find(id: current_user.id)
    # @user.new()
  end

  def graff
  end

end
