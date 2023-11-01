Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post '/accounts/signup', to: 'accounts#create'
  post '/accounts/verify_code', to: 'accounts#verify_code'
  post '/accounts/resend_code', to: 'accounts#resend_code'
  put '/accounts', to: 'accounts#update'
  post '/accounts/supplier_account', to: 'accounts#supplier_account'

  post '/logins/login', to: 'logins#login'

  post '/passwords/send_passcode', to: 'passwords#send_passcode'
  post '/passwords/reset_password', to: 'passwords#reset_password'

  resources :addresses, only: [:index, :create, :update, :destroy]
  resources :products, only: [:index, :create, :update, :destroy]


end
