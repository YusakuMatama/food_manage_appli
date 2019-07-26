Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/callback' => 'line_messages#callback'
  root 'users#index'

  resources :users do
    member do
      get 'graff'
    end
  end


end
