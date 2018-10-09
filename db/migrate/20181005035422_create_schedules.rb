class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.references :user, foreign_key: true
      t.string :event
      t.date :event_date
      t.time :start_at
      t.time :end_at
      t.string :location
      t.string :detail

      t.timestamps
    end
  end
end
