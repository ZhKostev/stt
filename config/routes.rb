Rails.application.routes.draw do
  resources :writers
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/_heath', to: 'health#index'
end
