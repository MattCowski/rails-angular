class AddAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    #add index because we'll be searching db for this
    add_index :users, :authentication_token, :unique => true
  end
end
