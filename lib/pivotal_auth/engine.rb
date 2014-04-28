require 'pivotal_auth/controllers/helpers'
require 'omniauth'
require 'omniauth-google-apps'
require 'pivotal/sass'
require 'sass-rails'
require 'compass-rails'

module PivotalAuth
  class Engine < ::Rails::Engine
    isolate_namespace PivotalAuth

    initializer 'pivotal_auth.helpers' do
      ActiveSupport.on_load(:action_controller) do
        include PivotalAuth::Controllers::Helpers
      end
    end

    initializer 'pivotal_auth.omniauth_google_apps' do
      Rails.application.config.middleware.use OmniAuth::Builder do
        provider :google_apps, :domain => 'pivotallabs.com'
      end
    end
  end
end
