class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :transaction_type, presence: true, inclusion: { in: %w[buy sell] }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :total_amount, presence: true, numericality: { greater_than: 0 }

  scope :recent, -> { order(created_at: :desc) }
  scope :buys, -> { where(transaction_type: 'buy') }
  scope :sells, -> { where(transaction_type: 'sell') }

  after_create :update_portfolio

  private

  def update_portfolio
    portfolio = user.portfolio
    portfolio_item = portfolio.portfolio_items.find_or_initialize_by(cryptocurrency: cryptocurrency)

    if transaction_type == 'buy'
      if portfolio_item.persisted?
        # Update average price using weighted average
        total_quantity = portfolio_item.quantity + quantity
        total_cost = (portfolio_item.quantity * portfolio_item.average_price) + total_amount
        portfolio_item.update(
          quantity: total_quantity,
          average_price: total_cost / total_quantity
        )
      else
        portfolio_item.update(
          quantity: quantity,
          average_price: price
        )
      end
    else # sell
      if portfolio_item.quantity >= quantity
        portfolio_item.update(quantity: portfolio_item.quantity - quantity)
        portfolio_item.destroy if portfolio_item.quantity.zero?
      end
    end

    portfolio.update_total_value
  end
end
