class PriceAlert < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :target_price, presence: true, numericality: { greater_than: 0 }
  validates :alert_type, presence: true, inclusion: { in: %w[above below] }
  validates :status, presence: true, inclusion: { in: %w[active triggered cancelled] }

  scope :active, -> { where(status: 'active') }
  scope :triggered, -> { where(status: 'triggered') }

  def check_and_trigger!
    return unless status == 'active'
    
    current_price = cryptocurrency.current_price
    should_trigger = case alert_type
    when 'above'
      current_price >= target_price
    when 'below'
      current_price <= target_price
    end

    if should_trigger
      update(status: 'triggered')
      # In production, send notification here (email, push, etc.)
    end
  end
end
