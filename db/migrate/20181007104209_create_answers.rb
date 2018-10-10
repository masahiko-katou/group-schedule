class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.references :user, foreign_key: true
      t.references :schedule, foreign_key: true
      t.string :status
      t.string :comment
      t.string :instrument

      t.timestamps
      
      t.index [:user_id, :schedule_id], unique: true
    end
  end
end
