class LineMessagesController < ApplicationController
  require "rubygems"
  require 'line/bot'

  def callback
    body = request.body.read
    @food_menu = Food.all
    @total_eat_data_today = ""
    @total_eat_data_yesterday = ""
    @total_eat_data_this_week = ""
    @total_eat_data_this_month = ""
    @reply_food_data = nil
    @total_calorie = 0
  
    events = client.parse_events_from(body)
    
    events.each { |event|
      @user_id = params["events"][0]["source"]["userId"]
      @current_user = User.find_by(line_id: @user_id)
      @user_message = params["events"][0]["message"]["text"]

      if (@current_user != nil)
        @user_eat_data = FoodEating.where(user_id: @current_user.id)
        @user_eat_data_today = FoodEating.where(user_id: @current_user.id).where(created_at: Time.zone.now.all_day)
        food_search()

        if (@reply_food_data != nil)
          FoodEating.create(food_id: @reply_food_data.id, user_id: @current_user.id)
          calc_total_calorie()

          response = @reply_food_data[:calorie] + "kcalです。" + "本日は#{@total_calorie}kcal摂取しています。"
          elsif (@user_message == "みす")
            response = "最新の入力内容を削除しました。。" 
            message = FoodEating.where(user_id: @current_user.id).last().destroy

          elsif (@user_message == "きょう")
            if @user_eat_data_today.present?
                eat_date_data_today()
                response = @total_eat_data_today
              else
                response = "何も食べていません。"
            end

          elsif (@user_message == "きのう")
            @user_eat_data_yesterday = FoodEating.where(user_id: @current_user.d).where(created_at: 1.day.ago.all_day)
            if @user_eat_data_yesterday.present?
                eat_date_data_yesterday()
                response = @total_eat_data_yesterday
              else
                response = "何も食べていません。"
            end

          elsif (@user_message == "こんしゅう")
            @user_eat_data_this_week = FoodEating.where(user_id: @current_user.id).where(created_at: Date.today.beginning_of_week.beginning_of_day..Date.today.end_of_week.end_of_day)
            if @user_eat_data_this_week.present?
                eat_date_data_this_week()
                response = "#{Date.today.all_week}\n" + @total_eat_data_this_week
              else
                response = "何も食べていません。"
            end


          elsif (@user_message == "へるぷ")
            response = "コマンド入力：結果\n食品名：カロリーと本日の合計カロリー表示\nきょう：今日食べたものを表示\nきのう：昨日食べたものを表示\nこんしゅう：今週食べたものを表示\nみす：最新データを消去"

          elsif (@user_message == "ほーむ")     
            response = "https://food-manage-appli.herokuapp.com/"

          else 
            response = "入力内容に誤りがあります。登録できる食べ物については、下記サイトの「カロリー早見表」に記載されている食べ物になります。\nhttps://food-manage-appli.herokuapp.com/"
        end
  
        elsif (@user_message == "id")     
          response = @user_id
        else
          response = "新規登録されていません。下記サイトに新規登録頂き、「使い方ページ」をご確認ください。\nhttps://food-manage-appli.herokuapp.com/"
      end

      case event.type
        when Line::Bot::Event::MessageType::Text
            message = {
              type: 'text',
              text: response
            }
            client.reply_message(event['replyToken'], message)
        end
      }
    head :ok
  end

private
  def food_search
    @reply_food_data = Food.find_by(hiragana_name: @user_message)
  end

  def eat_date_data_today
    @user_eat_data_today.each do |eat_data|
      eat_time = eat_data.created_at.in_time_zone('Tokyo')
      @total_eat_data_today += eat_data.food.name + "_" + eat_data.food.calorie + "kcal" + "::" + "#{eat_time.hour}" + "時" + "#{eat_time.min}" + "分" + "\n"
    end
  end

  def eat_date_data_yesterday
    @user_eat_data_yesterday.each do |eat_data|
      eat_time = eat_data.created_at.in_time_zone('Tokyo')
      @total_eat_data_yesterday += eat_data.food.name + "_" + eat_data.food.calorie + "kcal" + "::" + "#{eat_time.hour}" + "時" + "#{eat_time.min}" + "分" + "\n"
    end
  end

  def eat_date_data_this_week
    @user_eat_data_this_week.each do |eat_data|
      eat_time = eat_data.created_at.in_time_zone('Tokyo')
      @total_eat_data_this_week += eat_data.food.name + "_" + eat_data.food.calorie + "kcal" + "::" + "#{eat_time.day}" + "日" + "#{eat_time.hour}" + "時" + "#{eat_time.min}" + "分" + "\n"
    end
  end

end

