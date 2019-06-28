module AnswersHelper
  def all_attend(schedules)
    schedules.each do |schedule|
      if current_user.reaction?(schedule)
        next
      else
        answer = current_user.answers.create(schedule_id: schedule.id)
        answer.update(status: '◯')
      end
    end
  end
end
