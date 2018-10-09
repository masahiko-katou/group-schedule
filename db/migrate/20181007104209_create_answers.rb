class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.references :user, foreign_key: true
      t.references :reaction, foreign_key: { to_table: :schedules}
      t.string :status
      t.string :comment

      t.timestamps
      
      t.index [:user_id, :reaction_id], unique: true
    end
  end
end
