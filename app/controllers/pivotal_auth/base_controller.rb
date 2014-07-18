module PivotalAuth
  class BaseController < ActionController::Base
    skip_before_filter :authenticate_user!, :verify_authenticity_token
  end
end

