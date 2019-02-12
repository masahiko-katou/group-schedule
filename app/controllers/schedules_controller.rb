class SchedulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  require 'date'
  
  def index
    @schedules = Schedule.where("event_date >= ?", Date.current).order(:event_date).page(params[:page]).per(50)
    @answers = Answer.all
    past_schedules = Schedule.where("event_date < ?", Date.current)
    past_schedules.each do |past_schedule|
        past_schedule.destroy
    end
  end
  
  def show
    @schedule = Schedule.find(params[:id])
    @users = User.where(part: current_user.part).page(params[:page]).per(70)
    @count_users = User.where(part: current_user.part)
    counts(@schedule, @count_users)
  end

  def new
    @schedule = current_user.schedules.build
  end
  
  def create
    @schedule = current_user.schedules.build(schedule_params)
    @schedule.update(user_id: current_user.id)
    if @schedule.save
      flash[:success] = '予定を作成しました！'
      redirect_to @schedule
    else
      flash.now[:danger] = '予定を作成できませんでした...'
      render :new
    end
  end
  
  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:success] = '予定は正常に更新されました！'
      redirect_to @schedule
    else
      flash.now[:danger] = '予定は更新されませんでした...'
      render :edit
    end
  end
  
  def destroy
    @schedule.destroy
    flash[:success] = '予定を削除してしまいました！'
    redirect_to root_url
  end
  
  def section
    s = current_user.section
    @schedule = Schedule.find(params[:id])
    if s == 3 || s == 4
      @users = User.where(["section=? or section=?", '3', '4']).order(:instrument).page(params[:page]).per(100)
      @count_users = User.where(["section=? or section=?", '3', '4'])
    else
      @users = User.where(["section=? or section=?", '1',  '2']).order(:instrument).page(params[:page]).per(100)
      @count_users = User.where(["section=? or section=?", '1',  '2'])
    end
    counts(@schedule, @count_users)
  end
  
  def whole
    @schedule = Schedule.find(params[:id])
    @users = User.all.order(:instrument).page(params[:page]).per(500)
    @count_users = User.all
    counts(@schedule, @count_users)
  end
  
  def piece_1
    @schedule = Schedule.find(params[:id])
    @users = User.where(["piece_1=? or piece_1=? or piece_1=?", '本乗り', 'アシ', 'トラ']).order(:instrument).page(params[:page]).per(500)
    @count_users = User.all
    counts(@schedule, @count_users)
  end
  
  def piece_2
    @schedule = Schedule.find(params[:id])
    @users = User.where(["piece_2=? or piece_2=? or piece_2=?", '本乗り', 'アシ', 'トラ']).order(:instrument).page(params[:page]).per(500)
    @count_users = User.all
    counts(@schedule, @count_users)
  end
  
  def piece_3
    @schedule = Schedule.find(params[:id])
    @users = User.where(["piece_3=? or piece_3=? or piece_3=?", '本乗り', 'アシ', 'トラ']).order(:instrument).page(params[:page]).per(500)
    @count_users = User.all
    counts(@schedule, @count_users)
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:event, :event_date, :start_at, :end_at, :location, :detail)
  end
  
  def correct_user
    @schedule = current_user.schedules.find_by(id: params[:id])
    unless @schedule
      redirect_to root_url
    end
  end
end
