Rails.application.routes.draw do
 
  resources :users do
    resources :posts do
      resources :comments
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end