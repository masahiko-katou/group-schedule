class SchedulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @schedules = Schedule.all.order(:event_date)
    
  end
  
  def show
    @schedule = Schedule.find(params[:id])
    @answers = Answer.where(reaction_id: params[:id])
    @users = User.all
  end

  def new
    @schedule = Schedule.new 
  end
  
  def create
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @schedule
    else
      @schedules = current_user.microposts.order('created_at DESC').page(params[:page])
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
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:success] = 'スケジュールを削除しました。'
    redirect_to root_url
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:event, :event_date, :start_at, :end_at, :location, :detail)
  end
  
  def correct_user
    @schedule = current_user.schedule.find_by(id: params[:id])
    unless @schedule
      redirect_to root_url
    end
  end
end
