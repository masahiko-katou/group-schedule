class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    schedule = Schedule.find(params[:schedule_id])
    @answer = current_user.answers.find_or_create_by(schedule_id: schedule.id)
    @answer.update(answer_params)
    if @answer.status == '×' || @answer.status == '△'
      if @answer.save(context: :absent)
        flash[:success] = '回答を送信しました'
        redirect_to root_path
      else
        current_user.unreaction(schedule)
        flash[:danger] = '回答を送れませんでした。（理由が書かれていないかもしれません）'
        redirect_to root_path
      end
    else
      if @answer.save
        flash[:success] = '回答を送信しました'
        redirect_to root_path
      else
        flash[:danger] = '回答を送れませんでした'
        redirect_to root_path
      end
    end
  end

  def destroy
    schedule = Schedule.find(params[:schedule_id])
    current_user.unreaction(schedule)
    flash[:success] = '回答をリセットしました。' 
    redirect_to root_path
  end
  
  def answer_params
    params.require(:answer).permit(:status, :comment, :user_id, :schedule_id)
  end
end
