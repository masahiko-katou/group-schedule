class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @schedules = Schedule.where(user_id: current_user.id).order('created_at DESC')
    @schedule = Schedule.find_by(user_id: current_user.id)
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember @user
      numbering(@user)
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'ユーザ情報は正常に更新されました'
      redirect_to current_user
    else
      flash.now[:danger] = 'ユーザ情報は更新されませんでした'
      render :edit
    end
    numbering(current_user)
  end

  def edit
  end
  
  def destroy
    @user = User.find(params[:id])
     @user.destroy
      flash[:success] = '退会しました'
      redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :part)
  end
  
  def numbering(user)
    case user.part
    when "ヴァイオリン" then
      user.update(instrument: 1, section: 1)
    when "ヴィオラ" then
      user.update(instrument: 2, section: 1)
    when "チェロ" then
      user.update(instrument: 3, section: 2)
    when "コントラバス" then
      user.update(instrument: 4, section: 2)
    when "フルート" then
      user.update(instrument: 5, section: 3)
    when "オーボエ" then
      user.update(instrument: 6, section: 3)
    when "クラリネット" then
      user.update(instrument: 7, section: 3)
    when "ファゴット" then
      user.update(instrument: 8, section: 3)
    when "ホルン" then
      user.update(instrument: 9, section: 4)
    when "トランペット" then
      user.update(instrument: 10, section: 4)
    when "トロンボーン" then
      user.update(instrument: 11, section: 4)
    when "チューバ" then
      user.update(instrument: 12, section: 4)
    when "その他" then
      user.update(instrument: 13, section: 5)
    end
  end
end
