module PivotalAuth
  class SessionsController < BaseController
    def new
      if params[:message]
        flash[:error] = "Authentication failed. Please try logging in again. Reason was: #{params[:message]}"
      end
    end

    def create
      session[:emails] ||= []
      auth = request.env['omniauth.auth']
      session[:emails] << auth[:info][:email].downcase
      redirect_to session[:return_to] || main_app.root_url
    end

    def destroy
      session[:emails].delete(params[:email])
      redirect_to login_path, notice: "Successfully logged out #{params[:email]}."
    end

    def destroy_all
      session[:emails] = []
      redirect_to login_path, notice: "Successfully logged out."
    end
  end
end
