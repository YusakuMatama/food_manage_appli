namespace :push_line do 
  desc "push_line" # このタスクの説明を書く
  task push_line_message_morning: :environment do
    message = {
      type: 'text',
      text: '朝になりました。本日も頑張りましょう。食べた食べ物を入力すると、食品のカロリーと本日のトータルカロリーが表示されます。カロリー計算に使ってください。'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["line_channel_secret"]
      config.channel_token = ENV["line_channel_token"]
  }
    response = client.push_message("", message)
    p response
  end

  task push_line_message_night: :environment do
    message = {
      type: 'text',
      text: '夜10時になりました。本日もお疲れ様でした。'
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["line_channel_secret"]
        config.channel_token = ENV["line_channel_token"]
    }
    response = client.push_message("U6b9db5c98c87517cb1bbac89b18bdfa5", message)
    p response
  end

end