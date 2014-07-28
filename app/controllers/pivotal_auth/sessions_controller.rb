module PivotalAuth
  class SessionsController < BaseController
    def new
      if params[:message]
        flash[:error] = "Authentication failed. Please try logging in again. Reason was: #{params[:message]}"
      end
    end

    def create
      auth = request.env['omniauth.auth']
      session[:email] = auth[:uid].downcase
      redirect_to session[:return_to] || main_app.root_url
    end

    def destroy
      session[:email] = nil
      redirect_to login_path, notice: "Successfully logged out."
    end
  end
end
