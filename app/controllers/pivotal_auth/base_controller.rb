module PivotalAuth
  class BaseController < ApplicationController
    skip_before_filter :authenticate_user!, :verify_authenticity_token
  end
end

