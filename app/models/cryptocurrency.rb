class Cryptocurrency < ApplicationRecord
  has_many :portfolio_items, dependent: :destroy
  has_many :price_alerts, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :symbol, presence: true, uniqueness: true
  validates :name, presence: true
  validates :current_price, presence: true, numericality: { greater_than: 0 }

  scope :top_by_market_cap, -> { order(market_cap: :desc) }
  scope :trending, -> { where("price_change_percentage_24h > ?", 5) }
  scope :recently_updated, -> { order(updated_at: :desc) }

  def price_change_color
    return "text-gray-500" if price_change_percentage_24h.nil?
    price_change_percentage_24h >= 0 ? "text-green-500" : "text-red-500"
  end

  def formatted_price
    "$#{current_price.to_fs(:delimited, precision: 2)}"
  end

  def formatted_market_cap
    return "N/A" if market_cap.nil?
    if market_cap >= 1_000_000_000_000
      "$#{(market_cap / 1_000_000_000_000.0).round(2)}T"
    elsif market_cap >= 1_000_000_000
      "$#{(market_cap / 1_000_000_000.0).round(2)}B"
    elsif market_cap >= 1_000_000
      "$#{(market_cap / 1_000_000.0).round(2)}M"
    else
      "$#{market_cap.to_fs(:delimited)}"
    end
  end

  def to_param
    symbol.to_s.upcase
  end
end
