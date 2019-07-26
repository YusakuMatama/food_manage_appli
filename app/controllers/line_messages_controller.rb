class LineMessagesController < ApplicationController
  require "rubygems"
  require 'line/bot'  # gem 'line-bot-api'

  def callback
    body = request.body.read
    @food_menu = Food.all
    @user_eat_data = FoodEating.where(user_id: current_user.id)
    @total_calorie = 0
    @total_eat_data_today = ""
    @total_eat_data_yesterday = ""
    @total_eat_data_this_week = ""
    @total_eat_data_this_month = ""
    @reply_food_data = nil
  
    events = client.parse_events_from(body)
    
    events.each { |event|
      @user_message = params["events"][0]["message"]["text"]
      food_search()

      if (@reply_food_data != nil)
        FoodEating.create(name: @reply_food_data[:name], calorie: @reply_food_data[:calorie])
        calc_total_calorie()

        response = @reply_food_data[:calorie] + "kcalです。" + "本日は#{@total_calorie}kcal摂取しています。"
        elsif (@user_message == "みす")
          response = "最新の入力内容を削除しました。。" 
          message = FoodEating.where(user_id: current_user.id).last().destroy
        elsif (@user_message == "きょう")
          eat_date_data()
          response = @total_eat_data_today

        elsif (@user_message == "きのう")
          eat_date_data()
          response = @total_eat_data_yesterday
          
        elsif (@user_message == "こんしゅう")
          eat_date_data()
          response = @total_eat_data_this_week

        elsif (@user_message == "こんげつ")
          eat_date_data()
          response = @total_eat_data_this_month
        elsif (@user_message == "へるぷ")
          response = "コマンド入力：結果\n食品名：カロリーと本日の合計カロリー表示\nきょう：今日食べたものを表示\nきのう：昨日食べたものを表示\nこんしゅう：今週食べたものを表示\nこんげつ：今月食べたものを表示\nみす：最新データを消去"
        elsif (@user_message == "ぐらふ")     
          response = "http://localhost:3000"
        else 
          response = "入力内容に誤りがあります。"
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

  def food_search
    @food_menu.each do |food_menu|
      if (food_menu[:name] == @user_message)
        @reply_food_data = food_menu
      end
    end
  end

  def eat_date_data
    this_week = Date.today.all_week
    this_month = Date.today.all_month
    @user_eat_data.each do |eat_data|
      today_eat_time = eat_data[:created_at].in_time_zone('Tokyo')
      if (today_eat_time.to_s.match(/#{Date.today.to_s}.+/))
        @total_eat_data_today += eat_data[:name] + "_" + eat_data[:calorie] + "kcal" + "::" + "#{today_eat_time.hour}" + "時" + "#{today_eat_time.min}" + "分" + "\n"
      end

      if (today_eat_time.to_s.match(/#{Date.yesterday.to_s}.+/))
        @total_eat_data_yesterday += eat_data[:name] + "_" + eat_data[:calorie] + "kcal" + "::" + "#{today_eat_time.hour}" + "時" + "#{today_eat_time.min}" + "分" + "\n"
      end

      if (this_week.include?(Date.parse(today_eat_time.to_s)))
        @total_eat_data_this_week += eat_data[:name] + "_" + eat_data[:calorie] + "kcal" + "::" + "#{today_eat_time.day}" + "日" + "#{today_eat_time.hour}" + "時" + "#{today_eat_time.min}" + "分" + "\n"
      end

      if (this_month.include?(Date.parse(today_eat_time.to_s)))
        @total_eat_data_this_month += eat_data[:name] + "_" + eat_data[:calorie] + "kcal" + "::" + "#{today_eat_time.day}" + "日" + "#{today_eat_time.hour}" + "時" + "#{today_eat_time.min}" + "分" + "\n"
      end
    end
  end

  def calc_total_calorie
    @user_eat_data.each do |eat_data|
      today_eat_time = eat_data[:created_at].in_time_zone('Tokyo')
      if (today_eat_time.to_s.match(/#{Date.today.to_s}.+/))
        @total_calorie += eat_data[:calorie].to_i
      end
    end
  end
end
