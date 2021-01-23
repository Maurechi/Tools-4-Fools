Rails.application.routes.draw do
  get 'tools/index'
  get 'tools/new'
  get 'tools/create'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
