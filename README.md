# Bitcoin Price Tracker
Small script to track the price of Bitcoin in USD and EUR. It uses the [CoinBase API](https://developers.coinbase.com/api/v2) to get the current price.

## Usage
To use the script, you need to have Ruby installed. Then, you can run the script with the following command:
```
DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/1234567/abcyourwebhookurl" ruby main.rb
```
Or if you want to use the script in a Docker container using docker-compose, you can use the following command:
```
DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/1234567/abcyourwebhookurl" docker-compose up -d
```
