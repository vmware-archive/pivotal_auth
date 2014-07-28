require 'pivotal_auth/controllers/helpers'
require 'omniauth'
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

    generators do
      require "pivotal_auth/generators/initializer"
    end
  end
end
