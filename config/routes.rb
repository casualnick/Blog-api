Rails.application.routes.draw do
 
  resources :users, defaults: { format: :json } do
    resources :posts do
      resources :comments
    end
  end

end