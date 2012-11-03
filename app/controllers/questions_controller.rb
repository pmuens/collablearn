class QuestionsController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :destroy, :edit, :update]
  #before_filter :correct_user, only: [:edit, :update, :destroy]

  def new
    @title = 'Neue Frage erstellen'
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(params[:question])
    if @question.save
      redirect_to new_question_path, flash: { success: 'Frage mit dem Titel \'' + @question.title + '\' erfolgreich erstellt' }
    else
      @title = 'Neue Frage erstellen'
      render 'new'
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  #private
  #  def correct_user
  #    @user = User.find(params[:id])
  #    redirect_to root_path unless current_user?(@user)
  #  end
end