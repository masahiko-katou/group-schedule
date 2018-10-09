class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    schedule = Schedule.find(params[:reaction_id])
    current_user.answers.find_or_create_by(reaction_id: schedule.id)
    Answer.last.update(answer_params)
    flash[:success] = '回答を送信しました。'
    redirect_to root_path
  end

  def destroy
    schedule = Schedule.find(params[:reaction_id])
    current_user.deaction(schedule)
    flash[:success] = '回答をリセットしました。' 
    redirect_to root_path
  end
  
  def answer_params
    params.require(:answer).permit(:status, :comment, :user_id, :reaction_id)
  end
end
