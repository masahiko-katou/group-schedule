class AddPiece1ToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :piece_1, :string
  end
end
