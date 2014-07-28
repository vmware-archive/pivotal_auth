PivotalAuth::Engine.routes.draw do
  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'

  get 'auth/failure' => 'sessspions#new'

  match '/auth/saml/callback', to: 'sessions#create', via: [:get, :post]

  match '/auth/google_oauth2/callback', to: 'sessions#create', via: [:get, :post]
end

def google_auth_path
  '/auth/google_oauth2'
end
