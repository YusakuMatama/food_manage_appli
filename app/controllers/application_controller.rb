class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery except: [:callback]
  before_action :validate_signature, only:[:callback]

  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = "line_channel_secret"
      config.channel_token = "line_channel_token"
    }
  end
  
  def after_sign_in_path_for(resource)
      root_path
  end
end
