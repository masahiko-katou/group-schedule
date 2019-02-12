class AddPiece2ToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :piece_2, :string
  end
end
