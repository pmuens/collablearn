class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user
    else
      @title = 'Gemeinsam online lernen'
      @user = User.new
    end
  end
end