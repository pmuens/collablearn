class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to current_user
    else
      @title = 'Login'
    end
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = 'Unbekannte E-Mail / Passwort-Kombination'
      @title = 'Login'
      render 'new'
    else
      log_in user
      redirect_back_or user
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end