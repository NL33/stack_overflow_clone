class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_path, alert: "Not authorized" if current_user.nil? #relates to before filters. If user not logged in (ie, current_user = nil), then send error message if takes action not authorized to take
  end

end
