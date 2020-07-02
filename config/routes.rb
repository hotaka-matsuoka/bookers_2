Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get "home/about", to: "home#about" 
  resources :books
  resources :users
end
