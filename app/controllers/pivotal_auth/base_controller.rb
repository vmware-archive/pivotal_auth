module PivotalAuth
  class BaseController < ActionController::Base
    layout 'pivotal_auth/application'
    skip_before_filter :authenticate_user!, :verify_authenticity_token
  end
end

