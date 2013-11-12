class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, :token_authenticatable

 before_save :ensure_authentication_token

 has_many :shares, foreign_key: 'from_user_id'
end
