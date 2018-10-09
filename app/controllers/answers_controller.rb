class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    schedule = Schedule.find(params[:reaction_id])
    current_user.answers.find_or_create_by(reaction_id: schedule.id).update(answer_params)
    s = current_user.part
    current_user.answers.find_by(reaction_id: schedule.id).update(instrument: s)
    redirect_to root_path
  end

  def destroy
    schedule = Schedule.find(params[:reaction_id])
    current_user.deaction(schedule)
    flash[:success] = '回答をリセットしました。' 
    redirect_to root_path
  end
  
  def answer_params
    params.require(:answer).permit(:instrument, :status, :comment, :user_id, :reaction_id)
  end
end
