class SchedulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @schedules = Schedule.all.order(:event_date).page(params[:page])
    @answers = Answer.all
  end
  
  def show
    @schedule = Schedule.find(params[:id])
    @users = User.where(part: current_user.part).order(:part).page(params[:page])
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
      @schedules = current_user.schedules.order('created_at DESC').page(params[:page])
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
    flash[:success] = 'お望み通り予定を削除してしまいました！'
    redirect_to root_url
  end
  
  def section
    p = current_user.part
    if p == 'フルート' || p == 'オーボエ' || p == 'ファゴット' || p == 'クラリネット' || p == 'トランペット' || p == 'トロンボーン' || p == 'ホルン' || p == 'チューバ'
      @users = User.where(part: 'フルート').or(where(part: 'クラリネット')).or(where(part: 'ファゴット')).or(where(part: 'オーボエ')).or(where(part: 'トランペット')).or(where(part: 'トロンボーン')).or(where(part: 'チューバ')).or(where(part: 'ホルン')).order(:part)
    else
      @users = User.where(part: 'ヴァイオリン').or(where(part: 'ヴィオラ')).or(where(part: 'チェロ')).or(where(part: 'コントラバス')).order(:part)
    end
  end
  
  def whole
    @users = User.all.order(:part)
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
