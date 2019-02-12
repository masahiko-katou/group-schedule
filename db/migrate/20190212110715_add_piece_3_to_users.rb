class AddPiece3ToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :piece_3, :string
  end
end
