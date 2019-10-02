class SessionsController < ApplicationController
  require 'date'
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'ログインに失敗しました。パスワードが間違っているか、登録されていないメールアドレスを入力している可能性があります。'
      render 'new'
    end
  end

  def destroy
    forget(current_user)
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  def uraindex
    @schedules = Schedule.all.order(:event_date)
    @weeks = ["月", "火", "水", "木", "金", "土", "日"]
  end
  
  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
