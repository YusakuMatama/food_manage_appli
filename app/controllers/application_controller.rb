class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery except: [:callback]
  before_action :validate_signature, only:[:callback]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:line_id])
  end

  
  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["line_channel_secret"]
      config.channel_token = ENV["line_channel_token"]

    }
  end
  
  def after_sign_in_path_for(resource)
      root_path
  end

  def calc_total_calorie
      @user_eat_data_today.each do |eat_data|
      @total_calorie += eat_data.food.calorie.to_i
    end
  end

  

end
