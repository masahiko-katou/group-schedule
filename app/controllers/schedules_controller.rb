class SchedulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @schedules = Schedule.all.order(:event_date).page(params[:page])
  end
  
  def show
    @schedule = Schedule.find(params[:id])
    @users = User.all
    @answers = Answer.where(schedule_id: params[:id]).order("part DESC").page(params[:page])
  end

  def new
    @schedule = current_user.schedules.build(user_id: current_user.id)
  end
  
  def create
    @schedule = current_user.schedules.build(schedule_params)
    @schedule.update(user_id: current_user.id)
    if @schedule.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @schedule
    else
      @schedules = current_user.schedules.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = 'スケジュールは正常に更新されました'
      redirect_to @schedule
    else
      flash.now[:danger] = 'スケジュールは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @schedule.destroy
    flash[:success] = 'スケジュールを削除しました。'
    redirect_to root_url
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:user_id, :event, :event_date, :start_at, :end_at, :location, :detail)
  end
  
  def correct_user
    @schedule = current_user.schedules.find_by(id: params[:id])
    unless @schedule
      redirect_to root_url
    end
  end
end
