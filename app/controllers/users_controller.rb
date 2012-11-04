class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :home]
  #before_filter :correct_user, only: [:edit, :update, :home]

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

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end