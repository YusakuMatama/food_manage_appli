class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = UserStatus.find_by(user_id: current_user.id)
    @metabolism_under = Metabolism.find_by(id: @user.metabolism_id - 1)
    @metabolism_top = Metabolism.find_by(id: @user.metabolism_id)
  end
  
  def graff
    gon.data_calorie = []
    gon.data_date = [*(Date.today.beginning_of_week..Date.today.end_of_week)]
    @user_eat_data_this_week = FoodEating.where(user_id: @current_user.id).where(created_at: Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day)
    @this_week = Date.today.all_week
    total_calorie_1 = 0
    total_calorie_2 = 0
    total_calorie_3 = 0
    total_calorie_4 = 0
    total_calorie_5 = 0
    total_calorie_6 = 0
    total_calorie_7 = 0

      @user_eat_data.each do |eat_data|
        today_eat_time = eat_data[:created_at].in_time_zone('Tokyo')
        if (today_eat_time.to_s.match(/#{Date.today.beginning_of_week.to_s}.+/))
          total_calorie_1 += eat_data[:calorie].to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 1).to_s}.+/))
          total_calorie_2 += eat_data[:calorie].to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 2).to_s}.+/))
          total_calorie_3 += eat_data[:calorie].to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 3).to_s}.+/))
          total_calorie_4 += eat_data[:calorie].to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 4).to_s}.+/))
          total_calorie_5 += eat_data[:calorie].to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 5).to_s}.+/))
          total_calorie_6 += eat_data[:calorie].to_i

        else
          total_calorie_7 += eat_data[:calorie].to_i
        end        
      end
      gon.data_calorie.push(total_calorie_1, total_calorie_2, total_calorie_3, total_calorie_4, total_calorie_5, total_calorie_6, total_calorie_7)
  end

  def edit
    @user = User.find(id: current_user.id)
  end

  def new
    @user_status = UserStatus.new
  end

  def user_status
    user_status_params
    @user_status = UserStatus.new(@user_status_params)
    
    if @user_status.save
      redirect_to "/"
    end
  end

  private

  def calc_est_energy_require
    @age = params.require(:user_status).require(:age).to_i
    @gender = params.require(:user_status).require(:gender)
    @metabolism = Metabolism.where("age_base >= ?", @age).where(gender: @gender).first()
    @est_energy_req = @metabolism.base_metabolic_rate * 1.75
  end

  def user_status_params
    calc_est_energy_require
    @user_status_params = params.require(:user_status).permit(:name, :age, :gender, :weight, :line_id).merge(est_energy_req: @est_energy_req, metabolism_id: @metabolism.id, user_id: current_user.id)
  end
end