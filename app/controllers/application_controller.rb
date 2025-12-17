class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :authenticate_user!, unless: -> { controller_name == 'home' || devise_controller? }
  helper_method :current_portfolio

  protected

  def current_portfolio
    @current_portfolio ||= current_user&.portfolio
  end
end
