#!/bin/env ruby
# encoding: utf-8
class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user
    else
      @title = 'Gemeinsam online lernen'
      @user = User.new
    end
  end

  def search
    @title = 'Suchen und Entdecken'
    @random_collections = Collection.limit(10).sort_by{rand}
    if params[:condition] && params[:q] && ! params[:q].blank?
      if params[:condition] == 'collections_by_name'
        @result = Collection.where('name LIKE ?', "%#{params[:q]}%")
      elsif params[:condition] == 'users_by_username'
        @result = User.where('username LIKE ?', "%#{params[:q]}%")
      end
    end
  end
end