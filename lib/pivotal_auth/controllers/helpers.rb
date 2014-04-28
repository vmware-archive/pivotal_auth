module PivotalAuth
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :user_signed_in?
        helper_method :current_user_email
      end

      def user_signed_in?
        !current_user_email.nil?
      end

      def current_user_email
        session[:email]
      end

      private

      def authenticate_user!
        unless user_signed_in?
          session[:return_to] = request.url || root_url
          redirect_to pivotal_auth.login_path
        end
      end
    end
  end
end
