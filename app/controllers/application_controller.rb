class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(schedule, users)
      attend = 0
      late = 0
      absent = 0
    users.each do |user|
      attend += user.answers.where(status: "◯", schedule_id: schedule.id).count
      late += user.answers.where(status: "△", schedule_id: schedule.id).count
      absent += user.answers.where(status: "×", schedule_id: schedule.id).count
    end
    @attend_counts = attend
    @late_counts = late
    @absent_counts= absent
  end
end
