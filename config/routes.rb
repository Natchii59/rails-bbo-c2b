Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users, :controllers => { :sessions => 'sessions' }

  namespace :api do
    resources :products
    resources :widgets do
      collection do
        get 'token/:id', to: 'widgets#get_by_token'
      end
    end
  end

  root 'application#index'
  get '/*path', to: 'application#index', format: false
end
