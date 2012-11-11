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
    @interests = User.tag_counts_on(:interests)
    @collection_tags = Collection.tag_counts_on(:tags)
    if params[:condition] && params[:q] && ! params[:q].blank?
      if params[:condition] == 'collections_by_name'
        @result = Collection.where('name LIKE ?', "%#{params[:q]}%")
      elsif params[:condition] == 'users_by_username'
        @result = User.where('username LIKE ?', "%#{params[:q]}%")
      elsif params[:condition] == 'collections_by_tags'
        @result = Collection.tagged_with(params[:q], any: true, on: :tags).uniq
      elsif params[:condition] == 'users_by_interests'
        @result = User.tagged_with(params[:q], any: true, on: :interests).uniq
      end
    end
  end

  def learn
    @title = 'Lernen'
    @collection = Collection.find_by_id(params[:id])
    if !@collection
      redirect_to root_path, flash: { alert: 'Lernliste ist nicht vorhanden.' }
    end
  end
end