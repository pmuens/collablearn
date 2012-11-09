#!/bin/env ruby
# encoding: utf-8
class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :correct_user, only: [:edit, :update, :destroy]

  def new
    @title = 'Neue Frage erstellen'
    @collection = Collection.find_by_id(params[:collection_id])
    @question = @collection.questions.new
  end

  def create
    @collection = Collection.find_by_id(params[:collection_id])
    # TODO: Fix the current_user-issue (better solution than an appending to the array?)
    @question = @collection.questions.new(params[:question].merge(user_id: current_user.id))
    if @question.save
      redirect_to new_collection_question_path(@collection), flash: { success: 'Frage \'' + @question.title + '\' erfolgreich erstellt.' }
    else
      @title = 'Neue Frage erstellen'
      render 'new'
    end
  end

  def destroy
    Question.find_by_id(params[:id]).destroy
    redirect_to collection_path(params[:collection_id]), flash: { success: 'Frage erfolgreich gelöscht.' }
  end

  def edit
    @title = 'Frage editieren'
    @collection = Collection.find_by_id(params[:collection_id])
    @question = @collection.questions.find_by_id(params[:id])
  end

  def update
    @collection = Collection.find_by_id(params[:collection_id])
    @question = @collection.questions.find_by_id(params[:id])
    if @question.update_attributes(params[:question])
      redirect_to collection_path(@collection), flash: { success: 'Frage \'' + @question.title + '\' erfolgreich editiert.' }
    else
      @title = 'Frage editieren'
      render 'edit'
    end
  end

  #private
  #  def correct_user
  #    @user = User.find(params[:id])
  #    redirect_to root_path unless current_user?(@user)
  #  end
end