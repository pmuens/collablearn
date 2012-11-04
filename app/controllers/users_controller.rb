class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy, :home]
  #before_filter :correct_user, only: [:edit, :update, :destroy, :home]

  def home
    @title = 'Deine Startseite'
  end

  def show
    if user_signed_in? && params[:id].to_i == current_user.id.to_i
      redirect_to action: 'home', id: current_user.id
    else
      @user = User.find_by_id(params[:id])
      @title = @user.username + '\'s Seite'
    end
  end

  def edit
    @title = 'Einstellungen'
    @user = current_user
  end

  def destroy
    sign_out
    if User.find_by_id(params[:id]).destroy
      flash[:success] = 'Dein Account wurde erfolgreich entfernt. Wir werden dich vermissen :-('
    else
      flash[:error] = 'Das Entfernen des Accounts ist leider fehlgeschlagen. Bitte versuche es erneut.'
    end
    redirect_to root_path
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end