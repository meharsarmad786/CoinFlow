class CryptocurrenciesController < ApplicationController
  before_action :set_cryptocurrency, only: [:show]

  def index
    # Update prices periodically (in production, use background jobs)
    CryptoPriceService.update_cryptocurrency_prices if Cryptocurrency.count.zero? || Cryptocurrency.recently_updated.first&.updated_at < 5.minutes.ago
    
    @cryptocurrencies = Cryptocurrency.top_by_market_cap.page(params[:page]).per(50)
    @search = params[:search]
    
    if @search.present?
      @cryptocurrencies = @cryptocurrencies.where(
        "symbol ILIKE ? OR name ILIKE ?", 
        "%#{@search}%", "%#{@search}%"
      )
    end
  end

  def show
    @portfolio_item = current_user.portfolio&.portfolio_items&.find_by(cryptocurrency: @cryptocurrency)
    @recent_transactions = current_user.transactions.where(cryptocurrency: @cryptocurrency).recent.limit(10)
  end

  private

  def set_cryptocurrency
    symbol = params[:symbol] || params[:id]
    if symbol.present?
      # Case-insensitive lookup - symbols are stored in uppercase
      normalized_symbol = symbol.to_s.upcase
      @cryptocurrency = Cryptocurrency.find_by(symbol: normalized_symbol)
      raise ActiveRecord::RecordNotFound, "Couldn't find Cryptocurrency with symbol '#{symbol}'" if @cryptocurrency.nil?
    else
      raise ActiveRecord::RecordNotFound, "Symbol parameter is required"
    end
  end
end
