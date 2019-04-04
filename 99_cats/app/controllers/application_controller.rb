class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login_user!
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user 
      @user.reset_session_token
      session[:session_token] = @user.session_token 
      redirect_to cats_url 
    else 
      redirect_to new_session_url
    end 
  end

  def require_log_out
    redirect_to cats_url if logged_in?
  end 

  def require_log_in
    redirect_to cats_url unless logged_in?
  end 

end
