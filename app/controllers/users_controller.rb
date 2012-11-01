class UsersController < ApplicationController
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
    if params[:id] = current_user.id
      redirect_to action: 'home'
    else
      @title = 'Foo'
    end
  end

  def edit
    @title = 'Editiere dein Profil'
  end
end