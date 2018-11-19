class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(schedule)
    @attend_counts = schedule.answers.where(status: "◯").count
    @late_counts = schedule.answers.where(status: "△").count
    @absent_counts = schedule.answers.where(status: "×").count
  end
end
