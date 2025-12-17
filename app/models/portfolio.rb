class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_items, dependent: :destroy

  validates :total_value, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def update_total_value
    new_total = portfolio_items.sum do |item|
      item.quantity * item.cryptocurrency.current_price
    end
    update(total_value: new_total)
  end

  def total_invested
    portfolio_items.sum { |item| item.quantity * item.average_price }
  end

  def total_profit_loss
    total_value - total_invested
  end

  def profit_loss_percentage
    return 0 if total_invested.zero?
    ((total_profit_loss / total_invested) * 100).round(2)
  end
end
