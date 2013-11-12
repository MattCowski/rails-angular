class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable
  # before filter to make sure authentication_token generates when user is saved
  before_save :ensure_authentication_token
  has_many :authorizations, :dependent => :destroy
  has_many :shares, foreign_key: 'from_user-id'
end
