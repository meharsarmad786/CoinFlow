class PriceAlertsController < ApplicationController
  before_action :set_price_alert, only: [:destroy]

  def index
    @price_alerts = current_user.price_alerts.includes(:cryptocurrency).order(created_at: :desc)
    @active_alerts = @price_alerts.active
    @triggered_alerts = @price_alerts.triggered
  end

  def create
    @price_alert = current_user.price_alerts.build(price_alert_params)
    @price_alert.status = 'active'
    
    if @price_alert.save
      redirect_to price_alerts_path, notice: "Price alert created successfully!"
    else
      @price_alerts = current_user.price_alerts.includes(:cryptocurrency).order(created_at: :desc)
      @active_alerts = @price_alerts.active
      @triggered_alerts = @price_alerts.triggered
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @price_alert.destroy
    redirect_to price_alerts_path, notice: "Price alert deleted successfully!"
  end

  private

  def set_price_alert
    @price_alert = current_user.price_alerts.find(params[:id])
  end

  def price_alert_params
    params.require(:price_alert).permit(:cryptocurrency_id, :target_price, :alert_type)
  end
end
