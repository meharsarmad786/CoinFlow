class PortfoliosController < ApplicationController
  def index
    @portfolio = current_user.portfolio
    @portfolio.update_total_value
    @portfolio_items = @portfolio.portfolio_items.includes(:cryptocurrency).order(created_at: :desc)
  end

  def show
    @portfolio = current_user.portfolio
    @portfolio.update_total_value
  end
end
