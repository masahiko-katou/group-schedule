class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    schedule = Schedule.find(params[:reaction_id])
    current_user.answers.find_or_create_by(reaction_id: schedule.id)
    flash[:success] = '回答を送信しました。'
    redirect_to :back
  end

  def destroy
    schedule = Schedule.find(params[:reaction_id])
    current_user.deaction(schedule)
    flash[:success] = '回答をリセットしました。' 
    redirect_to :back
  end
  
  def answer_params
    params.require(:answer).permit(:status, :comment, :user_id, :reaction_id)
  end
end
