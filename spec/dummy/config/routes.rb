Rails.application.routes.draw do
  mount PivotalAuth::Engine => '/'
  root to: 'pages#home'
end
