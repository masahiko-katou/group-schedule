class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    schedule = Schedule.find(params[:schedule_id])
    @answer = current_user.answers.find_or_create_by(schedule_id: schedule.id)
    @answer.update(answer_params)
    if @answer.save
      flash[:success] = '回答を送信しました。'
      redirect_to root_path
    else
      flash[:danger] = '回答の送信に失敗しました。もう一度送り直してください。'
      redirect_to root_path
    end
  end

  def destroy
    schedule = Schedule.find(params[:schedule_id])
    current_user.deaction(schedule)
    flash[:success] = '回答をリセットしました。' 
    redirect_to root_path
  end
  
  def answer_params
    params.require(:answer).permit(:status, :comment, :user_id, :schedule_id)
  end
end
