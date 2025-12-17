class DashboardController < ApplicationController
  def index
    @portfolio = current_user.portfolio
    @portfolio_items = @portfolio.portfolio_items.includes(:cryptocurrency)
    @recent_transactions = current_user.transactions.recent.limit(10)
    @active_alerts = current_user.price_alerts.active.limit(5)
    @top_cryptos = Cryptocurrency.top_by_market_cap.limit(10)
    
    # Update portfolio value
    @portfolio.update_total_value
    
    # Prepare chart data
    prepare_portfolio_chart_data
    prepare_performance_chart_data
    prepare_market_trends_data
  end
  
  private
  
  def prepare_portfolio_chart_data
    if @portfolio_items.any?
      @portfolio_chart_labels = @portfolio_items.map { |item| item.cryptocurrency.symbol }
      @portfolio_chart_values = @portfolio_items.map { |item| item.current_value.round(2) }
      @portfolio_chart_colors = generate_chart_colors(@portfolio_items.count)
    end
  end
  
  def prepare_performance_chart_data
    # Generate dates for the last 30 days
    @performance_dates = (30.days.ago.to_date..Date.today).map { |d| d.strftime('%b %d') }
    
    # Calculate cumulative invested amount over time based on transactions
    all_transactions = current_user.transactions.order(:created_at)
    base_invested = 0
    
    # Build invested amount by date
    invested_by_date = {}
    cumulative_invested = 0
    
    all_transactions.each do |transaction|
      date_key = transaction.created_at.to_date
      if transaction.transaction_type == 'buy'
        cumulative_invested += transaction.total_amount
      else
        cumulative_invested -= transaction.total_amount
      end
      invested_by_date[date_key] = cumulative_invested
    end
    
    # Fill in values for each date in the last 30 days
    @performance_values = []
    @performance_profits = []
    current_invested = @portfolio.total_invested
    
    (30.days.ago.to_date..Date.today).each do |date|
      # Get invested amount up to this date
      date_invested = invested_by_date.select { |k, v| k <= date }.values.last || 0
      
      # For demo: simulate portfolio growth (in production, use historical prices)
      # Show gradual growth from invested to current value
      days_ago = (Date.today - date).to_i
      progress = 1.0 - (days_ago.to_f / 30.0)
      simulated_value = date_invested + ((@portfolio.total_value - @portfolio.total_invested) * progress)
      
      @performance_values << [simulated_value, date_invested].max.round(2)
      @performance_profits << (simulated_value - date_invested).round(2)
    end
  end
  
  def prepare_market_trends_data
    @market_trends_labels = @top_cryptos.map { |c| c.symbol }
    @market_trends_prices = @top_cryptos.map { |c| c.current_price.to_f }
    @market_trends_changes = @top_cryptos.map { |c| c.price_change_percentage_24h.to_f }
  end
  
  def generate_chart_colors(count)
    colors = [
      'rgba(139, 92, 246, 0.8)',  # purple
      'rgba(236, 72, 153, 0.8)',  # pink
      'rgba(59, 130, 246, 0.8)',  # blue
      'rgba(34, 197, 94, 0.8)',   # green
      'rgba(251, 146, 60, 0.8)',  # orange
      'rgba(168, 85, 247, 0.8)',  # violet
      'rgba(239, 68, 68, 0.8)',   # red
      'rgba(20, 184, 166, 0.8)',  # teal
      'rgba(245, 158, 11, 0.8)',  # amber
      'rgba(99, 102, 241, 0.8)'   # indigo
    ]
    colors.cycle.take(count)
  end
end
