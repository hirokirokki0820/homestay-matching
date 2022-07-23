class AddAccountNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :account_name, :string
  end
end
