class UsersController < ApplicationController
  before_action :authenticate_user!, except:[:index]
  before_action :confirm_user_profile, except: [:index, :new, :user_status]

  def index
  end

  def show
    @user = UserStatus.find_by(user_id: current_user.id)
    @metabolism_under = Metabolism.find_by(id: @user&.metabolism_id - 1)
    @metabolism_top = Metabolism.find_by(id: @user&.metabolism_id)

    @user_eat_data_today = FoodEating.where(user_id: current_user.id).where(created_at: Time.zone.now.all_day)
    @total_calorie = 0
    calc_total_calorie()

    @user_eat_data = FoodEating.where(user_id: current_user.id)
    @user_eat_data_yesterday = FoodEating.where(user_id: current_user.id).where(created_at: 1.day.ago.all_day)
    @user_eat_data_this_month = FoodEating.where(user_id: current_user.id).where(created_at: Date.today.all_month)
    @user_eat_data_this_week = FoodEating.where(user_id: current_user.id).where(created_at: Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day)
  end
  
  def graff
    gon.data_calorie = []
    gon.data_date = [*(Date.today.beginning_of_week..Date.today.end_of_week)]
    @user_eat_data_this_week = FoodEating.where(user_id: current_user.id).where(created_at: Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day)
    @this_week = Date.today.all_week
    total_calorie_1 = 0
    total_calorie_2 = 0
    total_calorie_3 = 0
    total_calorie_4 = 0
    total_calorie_5 = 0
    total_calorie_6 = 0
    total_calorie_7 = 0

      @user_eat_data_this_week.each do |eat_data|
        today_eat_time = eat_data.created_at.in_time_zone('Tokyo')
        if (today_eat_time.to_s.match(/#{Date.today.beginning_of_week.to_s}.+/))
          total_calorie_1 += eat_data.food.calorie.to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 1).to_s}.+/))
          total_calorie_2 += eat_data.food.calorie.to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 2).to_s}.+/))
          total_calorie_3 += eat_data.food.calorie.to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 3).to_s}.+/))
          total_calorie_4 += eat_data.food.calorie.to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 4).to_s}.+/))
          total_calorie_5 += eat_data.food.calorie.to_i

        elsif (today_eat_time.to_s.match(/#{(Date.today.beginning_of_week + 5).to_s}.+/))
          total_calorie_6 += eat_data.food.calorie.to_i

        else
          total_calorie_7 += eat_data.food.calorie.to_i
        end        
      end
      gon.data_calorie.push(total_calorie_1, total_calorie_2, total_calorie_3, total_calorie_4, total_calorie_5, total_calorie_6, total_calorie_7)
  end

  def edit
    @user_status = UserStatus.find_by(user_id: current_user.id)
  end

  def update
    @user_status = UserStatus.find_by(user_id: current_user.id)
    if @user_status.update(user_status_params)
      respond_to do |format|
        format.json
      end

      else
        respond_to do |format|
          format.html{redirect_to "/users/#{params[:id]}/edit"}
          format.json
        end
    end
  end

  def new
    @user_status = UserStatus.new
  end

  def user_status
    @user_status = UserStatus.new(user_status_params)
    
    if @user_status.save
      respond_to do |format|
        format.json
      end
      else
        respond_to do |format|
          format.html{redirect_to "/users/new"}
          format.json
        end
    end
  end

  private
  def calc_est_energy_require
    @age = params.require(:user_status).permit(:age)
    @gender = params.require(:user_status).permit(:gender)
    @metabolism = Metabolism.where("age_base >= ?", @age["age"].to_i).where(gender: @gender["gender"]).first()
    @est_energy_req = @metabolism.base_metabolic_rate * 1.75
  end

  def user_status_params
    calc_est_energy_require
    @user_status_params = params.require(:user_status).permit(:name, :age, :gender, :weight).merge(est_energy_req: @est_energy_req, metabolism_id: @metabolism.id, user_id: current_user.id)
  end

  def confirm_user_profile
    if current_user.user_status.nil?
      redirect_to "/users/new"
    end
  end
end