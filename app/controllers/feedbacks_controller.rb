#!/bin/env ruby
# encoding: utf-8
class FeedbacksController < ApplicationController
  def create
    if not params[:feedback].blank?
      if FeedbackMailer.feedback_email(params[:feedback]).deliver
        redirect_to :back, flash: { success: 'Vielen Dank! Das Collablearn-Team wird sich dein Feedback nun anschauen!' }
      else
        redirect_to :back, flash: { alert: 'Leider ist beim Absenden des Feedbacks ein Fehler aufgetreten :-( Versuche es bitte erneut!' }
      end
    else
      redirect_to :back, flash: { alert: 'Das Feedback-Feld darf nicht leer sein.' }
    end
  end
end