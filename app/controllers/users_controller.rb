class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @schedules = current_user.schedules.order('created_at DESC').page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'スケジュールは正常に更新されました'
      redirect_to current_user
    else
      flash.now[:danger] = 'スケジュールは更新されませんでした'
      render :edit
    end
  end

  def edit
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :part)
  end
end
