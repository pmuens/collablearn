class UsersController < ApplicationController
  before_filter :authenticate, only: [:edit, :update, :home, :destroy]
  before_filter :correct_user, only: [:edit, :update, :home, :destroy]

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      redirect_to current_user, :flash => { :success => 'Willkommen auf Collablearn!' }
    else
      @title = 'Gemeinsam online lernen'
      render 'static_pages/home'
    end
  end

  def home
    @title = 'Deine Startseite'
  end

  def show
    if logged_in? && params[:id].to_i == current_user.id.to_i
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
    log_out
    if User.find_by_id(params[:id]).destroy
      flash[:success] = 'Dein Account wurde erfolgreich entfernt. Wir werden dich vermissen :-('
    else
      flash[:error] = 'Das Entfernen des Accounts ist leider fehlgeschlagen. Bitte versuche es erneut.'
    end
    redirect_to root_path
  end

  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      redirect_to root_path, flash: { success: 'Passwort erfolgreich aktualisiert! Bitte mit neuem Passwort einloggen' }
    else
      @title = 'Einstellungen'
      render 'edit'
    end
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end