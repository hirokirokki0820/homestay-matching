class AddContentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :content, :text
  end
end
