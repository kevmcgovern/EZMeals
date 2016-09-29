Rails.application.routes.draw do
  root 'welcome#index'
  resources :users
  resources :plans
  resources :recipes
  resources :ingredients

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
