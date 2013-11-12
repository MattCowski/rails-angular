class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth_hash = env["omniauth.auth"]
    uid = auth_hash['extra']['user_hash']['id']
    name = auth_hash['user_info']['name']
    auth = Authorization.find_by_provider_and_uid("twitter", uid)
    if auth
      ## We already know about this user who is signing in with
      # the provider: just return the user associated with the Authorization
      user = auth.user
    else
      ## Is a user signed in already? If not, then find or create
      # the user
      unless current_user
        unless user = User.find_by_name(name)
          user = User.create({
            name: name,
            password: Devise.friendly_token[0,8],
            email: "#{UUIDTools::UUID.random_create}@shareup.com"
          })
        end
      else
        user = current_user
      end

      ## Finally, create an authorization for the current user
      unless auth = user.authorizations.find_by_provider("twitter")
        auth = user.authorizations.build(provider: "twitter")
        user.authorizations << auth
      end
      auth.update_attributes({
          uid: uid,
          token: auth_hash['credentials']['token'],
          secret: auth_hash['credentials']['secret'],
          name: name,
          url: "http://twitter.com/#{name}"
        })
      ## Return user
      user
    end
  end
end
