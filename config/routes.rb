Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, except: :index
  resources :plans
  resources :recipes, except: [:edit, :create, :new] do
	  resources :ingredients, except: [:destroy, :update, :edit, :new, :create]
	end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
