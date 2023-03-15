require "json"
require "net/http"

discord_webhook_url = ENV["DISCORD_WEBHOOK_URL"]

def round(number)
  if number % 100 == 0
    return number
  else
    return (number / 100).to_i * 100
  end
end

def send_to_discord(message)
  #get webbook url from environment variable
  url = URI(ENV["DISCORD_WEBHOOK_URL"])
  req = Net::HTTP::Post.new(url, "Content-Type" => "application/json")
  req.body = { content: message }.to_json
  res = Net::HTTP.start(url.hostname, url.port, :use_ssl => url.scheme == "https") do |http|
    http.request(req)
  end
end

puts "Starting BTC price tracker..."
puts "Press Ctrl-C to stop"
puts "Message will be sent to Discord when BTC price changes by $100"
puts "Your Discord webhook URL is: #{discord_webhook_url}"

change = 100
last_price = nil
url = URI("https://api.coinbase.com/v2/prices/BTC-USD/buy")

while true
  response = Net::HTTP.get(url)
  data = JSON.parse(response)

  price = data["data"]["amount"].to_f
  rounded_price = round(price)
  if rounded_price % change === 0 && rounded_price != last_price
    if !last_price.nil?
      if rounded_price > last_price
        message = "BTC is up to $#{rounded_price}"
      else
        message = "BTC is down to $#{rounded_price}"
      end
    end
    puts message
    send_to_discord(message)
    last_price = rounded_price
  end
  sleep(60)
end
