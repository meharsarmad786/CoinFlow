class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :portfolio, dependent: :destroy
  has_many :price_alerts, dependent: :destroy
  has_many :transactions, dependent: :destroy

  after_create :create_portfolio

  private

  def create_portfolio
    Portfolio.create!(user: self, total_value: 0.0)
  end
end
