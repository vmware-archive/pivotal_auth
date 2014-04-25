Rails.application.routes.draw do

  mount PivotalAuth::Engine => "/pivotal_auth"
end
