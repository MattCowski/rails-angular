class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
# skip CSRF
  protect_from_forgery with: :null_session

  #add access controll headers and auth our user
  before_filter :set_cors_headers
  before_filter :cors_preflight

  def ping
    render status: 200,
        json: {
          success: "true"
        }
  end

  def set_cors_headers
  # will set proper HTTP headers for the response from our server
  # for production, add domain in app_config to enable CORS
    headers['Access-Control-Allow-Origin'] = AppConfig.client['origin']
    # OPTION action is for client to see if server has CORS enabled (renders empty page)
    headers['Access-Control-Allow-Methods'] = 'GET,POST,PUT,DELETE,OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "3628800"
  end

  def cors_preflight
    #check if user is logged in or not
    head(:ok) if request.method == :options
  end

  def authenticate_cors_user
    if request.xhr? and !user_signed_in?
      render status: 401,
            json: {
              error: "You are not authenticated to run this action"
            }
    end
  end

end
