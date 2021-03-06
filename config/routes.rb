Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations',sessions: 'users/sessions' }
  root to: 'homes#top'
  get '/home/about', to: 'homes#show', as: 'about'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only:[:create, :index, :show, :edit, :destroy, :update]do
    resources :book_comments, only:[:create, :destroy]
    resources :favorites, only:[:create, :destroy]
  end

resources :users, only:[:index, :show, :edit, :update]do
  member do
      get :following, :followers
    end
end
resources :relationships, only: [:create, :destroy]

get '/search', to: 'searches#search'

# DM機能
resources :messages, only: [:create]
resources :rooms, only: [:create, :show]


end


