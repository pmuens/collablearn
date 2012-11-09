#!/bin/env ruby
# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  #before_filter :correct_user, only: [:edit, :update_password, :update, :home]

  def home
    @title = 'Deine Startseite'
  end

  def settings
    @title = 'Einstellungen'
    @user = current_user
  end

  def show
    if user_signed_in? && params[:id].to_i == current_user.id.to_i
      redirect_to action: 'home', id: current_user.id
    else
      @user = User.find_by_id(params[:id])
      @own_collections = @user.collections
      @followed_collections = @user.following_collections
      @title = @user.username + '\'s Seite'
    end
  end

  def fellowships_users
    @title = 'Übersicht Nutzer folgen'
    @your_followings = current_user.following_users
    @your_followers = current_user.user_followers
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user, bypass: true
      redirect_to root_path, flash: { success: 'Passwort erfolgreich aktualisiert.' }
    else
      @title = 'Einstellungen'
      render 'edit'
    end
  end

  def follow_user
    @followed_user = User.find_by_id(params[:id])
    if !current_user.follow(@followed_user)
      flash[:alert] = 'Folgen leider nicht erfolgreich :-( Versuche es erneut.'
    end
    redirect_to :back
  end

  def unfollow_user
    @followed_user = User.find_by_id(params[:id])
    if !current_user.stop_following(@followed_user)
      flash[:alert] = 'Nicht mehr folgen leider nicht erfolgreich :-( Versuche es erneut.'
    end
    redirect_to :back
  end

  def follow_collection
    @followed_collection = Collection.find_by_id(params[:id])
    if !current_user.follow(@followed_collection)
      flash[:alert] = 'Folgen leider nicht erfolgreich :-( Versuche es erneut'
    end
    redirect_to :back
  end

  def unfollow_collection
    @followed_collection = Collection.find_by_id(params[:id])
    if !current_user.stop_following(@followed_collection)
      flash[:alert] = 'Nicht mehr folgen leider nicht erfolgreich :-( Versuche es erneut.'
    end
    redirect_to :back
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
end