Rails.application.routes.draw do
  devise_for :users
#  resources :users do
#   resources :reservations, only: [:index]
# end

  root to: 'pages#home'
  resources :tools do
    resources :reservations, only: [:new, :create]
  end


  resources :reservations, only: [:destroy, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
