class PagesController < ApplicationController
  def home
    if logged_in?
      redirect_to current_user
    else
      @title = 'Gemeinsam online lernen'
      @user = User.new
    end
  end
end