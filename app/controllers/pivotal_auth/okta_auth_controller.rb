module PivotalAuth
  class OktaAuthController < SamlController
    layout 'pivotal_auth/application'
    skip_before_filter :authenticate_user!

    def sign_in(user)
      session[:email] = user.email
    end

    def redirect_url
      session[:return_to] || main_app.root_path
    end
  end
end
