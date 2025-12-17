class CryptoPriceService
  BASE_URL = "https://api.coingecko.com/api/v3"

  def self.fetch_top_cryptocurrencies(limit: 100)
    begin
      response = HTTParty.get(
        "#{BASE_URL}/coins/markets",
        query: {
          vs_currency: 'usd',
          order: 'market_cap_desc',
          per_page: limit,
          page: 1,
          sparkline: false,
          price_change_percentage: '24h'
        },
        timeout: 10
      )

      if response.success?
        response.parsed_response.map do |coin_data|
          {
            symbol: coin_data['symbol'].upcase,
            name: coin_data['name'],
            current_price: coin_data['current_price'] || 0,
            market_cap: coin_data['market_cap'] || 0,
            volume_24h: coin_data['total_volume'] || 0,
            price_change_24h: coin_data['price_change_24h'] || 0,
            price_change_percentage_24h: coin_data['price_change_percentage_24h'] || 0
          }
        end
      else
        []
      end
    rescue => e
      Rails.logger.error "Error fetching crypto prices: #{e.message}"
      []
    end
  end

  def self.update_cryptocurrency_prices
    crypto_data = fetch_top_cryptocurrencies
    
    crypto_data.each do |data|
      crypto = Cryptocurrency.find_or_initialize_by(symbol: data[:symbol])
      crypto.update!(
        name: data[:name],
        current_price: data[:current_price],
        market_cap: data[:market_cap],
        volume_24h: data[:volume_24h],
        price_change_24h: data[:price_change_24h],
        price_change_percentage_24h: data[:price_change_percentage_24h]
      )
    end

    # Trigger price alerts
    PriceAlert.active.find_each do |alert|
      alert.check_and_trigger!
    end
  end

  def self.fetch_crypto_by_symbol(symbol)
    begin
      response = HTTParty.get(
        "#{BASE_URL}/simple/price",
        query: {
          ids: symbol.downcase,
          vs_currencies: 'usd',
          include_24hr_change: true,
          include_market_cap: true,
          include_24hr_vol: true
        },
        timeout: 10
      )

      if response.success? && response.parsed_response[symbol.downcase]
        data = response.parsed_response[symbol.downcase]
        {
          current_price: data['usd'] || 0,
          market_cap: data['usd_market_cap'] || 0,
          volume_24h: data['usd_24h_vol'] || 0,
          price_change_24h: data['usd_24h_change'] || 0
        }
      else
        nil
      end
    rescue => e
      Rails.logger.error "Error fetching crypto price for #{symbol}: #{e.message}"
      nil
    end
  end
end

