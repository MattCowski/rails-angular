class Users::UsersController < Devise::SessionsController
  protect_from_forgery with: :exception, except: [:is_user]  
  respond_to :json

  def is_user
    authenticate_user!
    render status: 200,
        json: {
          success: !User.find_by_name(params[:name]).blank?
        }
  end
  
end