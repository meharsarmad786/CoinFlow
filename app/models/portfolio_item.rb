class PortfolioItem < ApplicationRecord
  belongs_to :portfolio
  belongs_to :cryptocurrency

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :average_price, presence: true, numericality: { greater_than: 0 }

  def current_value
    quantity * cryptocurrency.current_price
  end

  def profit_loss
    current_value - (quantity * average_price)
  end

  def profit_loss_percentage
    return 0 if average_price.zero?
    (((cryptocurrency.current_price - average_price) / average_price) * 100).round(2)
  end
end
