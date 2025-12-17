class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    # Load initial crypto data if empty
    if Cryptocurrency.count.zero?
      CryptoPriceService.update_cryptocurrency_prices
    end
    @top_cryptos = Cryptocurrency.top_by_market_cap.limit(10)
    @trending_cryptos = Cryptocurrency.trending.limit(5)
  end
end
