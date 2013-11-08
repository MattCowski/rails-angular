# This model exists so we can support multiple Omniauth providers
class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      # i.e. twitter
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :token
      t.string :secret
      # users name
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
