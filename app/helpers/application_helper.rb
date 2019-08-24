module ApplicationHelper
  # マイページのhtmlヘルパー
  def user_name
    "#{UserStatus.find_by(user_id: current_user.id).name}さんのデータ"
  end

  def user_estimate_calorie_require
    "#{UserStatus.find_by(user_id: current_user.id).est_energy_req}kcal"
  end

  def metabolism
    @user = UserStatus.find_by(user_id: current_user.id)
    @metabolism_under = Metabolism.find_by(id: @user&.metabolism_id - 1)
    @metabolism_top = Metabolism.find_by(id: @user&.metabolism_id)
    
    unless @user.metabolism_id == 1
        "#{@metabolism_under.age_base}才から#{@metabolism_top.age_base}才までの平均データ"
      else
        "#{@metabolism_top.age_base}才以下の平均データ"
    end
  end

  def base_weight
    "#{@metabolism_top.base_weight}kg"
  end

  def base_metabolism
    "#{@metabolism_top.base_metabolic_rate}kcal"
  end

  def user_eat_data
    @user_eat_data = FoodEating.where(user_id: current_user.id)

    unless @user_eat_data.blank?
      "#{@user_eat_data[0].created_at.year}年 #{@user_eat_data[0].created_at.month}月から #{@user_eat_data.last().created_at.year}年 #{@user_eat_data.last().created_at.month}月まで"
    end
  end

  def user_eat_food_data
    @user = UserStatus.find_by(user_id: current_user.id)
    @user_eat_data_today = FoodEating.where(user_id: current_user.id).where(created_at: Time.zone.now.all_day)
    @user_eat_data_yesterday = FoodEating.where(user_id: current_user.id).where(created_at: 1.day.ago.all_day)
    @user_eat_data_this_month = FoodEating.where(user_id: current_user.id).where(created_at: Date.today.all_month)
    @user_eat_data_this_week = FoodEating.where(user_id: current_user.id).where(created_at: Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day)
  end
end
