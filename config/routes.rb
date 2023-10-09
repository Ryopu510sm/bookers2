Rails.application.routes.draw do
 
  devise_for :users
  root to: 'homes#top'
  #get 'new_user_session_path' => 'sessions#new'
  resources :books 
  resources :users
  get '/home/about', to: 'homes#about', as: 'about'
  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
