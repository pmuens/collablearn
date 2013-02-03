#!/bin/env ruby
# encoding: utf-8
class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user
    else
      @title = 'Gemeinsam online lernen'
    end
  end

  def search
    @title = 'Suchen und Entdecken'
    @random_collections = Collection.limit(10).sort_by{rand}
    @random_users = User.limit(10).sort_by{rand}
    @interests = User.tag_counts_on(:interests)
    @collection_tags = Collection.tag_counts_on(:tags)
    if params[:condition] && params[:q] && ! params[:q].blank?
      if params[:condition] == 'collections_by_name'
        @result = Collection.where('lower(name) LIKE ?', "%#{params[:q].downcase}%").order('name ASC')
      elsif params[:condition] == 'users_by_username'
        @result = User.where('lower(username) LIKE ?', "%#{params[:q].downcase}%").order('username ASC')
      elsif params[:condition] == 'users_by_name'
        @result = User. where('lower(name) LIKE ?', "%#{params[:q].downcase}%").order('name ASC')
      elsif params[:condition] == 'collections_by_tags'
        @result = Collection.tagged_with(params[:q], any: true, on: :tags).uniq
      elsif params[:condition] == 'users_by_interests'
        @result = User.tagged_with(params[:q], any: true, on: :interests).uniq
      end
    end
  end

  def learn
    @collection = Collection.find_by_id(params[:id])
    if !@collection || @collection.questions.count == 0
      redirect_to root_path, flash: { alert: 'Die Lernliste existiert leider nicht, bzw. es sind in der angeforderten Lernliste keine Fragen vorhanden.' }
    else
      @questions = @collection.questions
      @title = @collection.name + ' lernen'
    end
  end

  def masthead
    @title = 'Impressum'
  end

  def terms_of_service
    @title = 'Nutzungsbedingungen'
  end

  def privacy
    @title = 'Datenschutz'
  end

  def statistics
    @title = 'Statistiken'
    @users = User.all
    @collections = Collection.all
    @questions = Question.all
  end
end