PivotalAuth::Engine.routes.draw do
  get '/login' => 'sessions#new', as: 'login'
  get '/logout/:email' => 'sessions#destroy',     as: 'logout', constraints: { email: /[^\/]+/ }
  get '/logout'        => 'sessions#destroy_all', as: 'logout_all'

  get '/auth/failure' => 'sessions#new'
  match 'auth/google_apps/callback' => 'sessions#create', :via => [:get, :post]

  get '/saml/init' => 'okta_auth#init'
  post '/saml/consume' => 'okta_auth#consume'
end

def google_auth_path
  '/auth/google_apps'
end
