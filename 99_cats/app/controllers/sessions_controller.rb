class SessionsController < ApplicationController
  before_action :require_log_out, only: [:new, :create]

  def new
    
  end

  def create
    login_user!
  end

  def destroy
    #find user and destroy it?
    @user = current_user
    @user.reset_session_token
    session[:session_token] = nil
    redirect_to cats_url
  end
end
