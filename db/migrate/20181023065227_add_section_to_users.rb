class AddSectionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :section, :integer
  end
end
