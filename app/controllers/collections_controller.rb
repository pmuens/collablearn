#!/bin/env ruby
# encoding: utf-8
class CollectionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  #before_filter :correct_user, only: [:edit, :update_password, :update, :home]

  def index
    @title = 'Lernlisten verwalten'
    @own_collections = current_user.collections.all
    @followed_collections = current_user.collections.all
  end

  def new
    @title = 'Neue Lernliste erstellen'
    @collection = Collection.new
  end

  def create
    @collection = current_user.collections.new(params[:collection])
    if @collection.save
      redirect_to collection_path(@collection), flash: { success: 'Lernliste \'' + @collection.name + '\' erfolgreich erstellt' }
    else
      @title = 'Neue Lernliste erstellen'
      render 'new'
    end
  end

  def show
    @collection = Collection.find_by_id(params[:id])
    @questions = @collection.questions
    @title = @collection.name
  end

  def edit
    @title = 'Lernliste editieren'
    @collection = Collection.find_by_id(params[:id])
  end

  def update
    @collection = Collection.find_by_id(params[:id])
    if @collection.update_attributes(params[:collection])
      redirect_to collections_path, flash: { success: 'Lernliste \'' + @collection.name + '\' erfolgreich editiert' }
    else
      @title = 'Lernliste editieren'
      render 'edit'
    end 
  end

  def destroy
    Collection.find_by_id(params[:id]).destroy
    redirect_to collections_path, flash: { success: 'Lernliste erfolgreich gelöscht' }
  end

  #private
  #  def correct_user
  #    @user = User.find(params[:id])
  #    redirect_to root_path unless current_user?(@user)
  #  end
end