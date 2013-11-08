# SessionsService returns info about current user which enables API to talk back to Rails app and query info about him
class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # check to ensure user is logged in
  def show_current_user
    reject_if_not_authorized_request!
    render status: 200,
      json: {
        success: true,
        info: "Current user",
        user: current_user
      }
  end

  # if not, kick out and show response
  def failure
    render status: 401,
          json: {
            success: false,
            info: "Unauthorized"
          }
  end

  private

  def reject_if_not_authorized_request!
  # use raw warden helper to auth users
    warden.authenticate!(
      scope: resource_name, 
      recall: "#{controller_path}#failure")
  end
end
