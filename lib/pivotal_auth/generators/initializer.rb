require 'rails/generators/base'

module PivotalAuth
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../files', __FILE__)

      def copy_files
        copy_file "omniauth.rb", "config/initializers/omniauth.rb"
      end
    end
  end
end
