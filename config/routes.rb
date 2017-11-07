Rails.application.routes.draw do
  get 'order_items/create'

  get 'order_items/update'

  get 'order_items/destroy'

  get 'cart/show'

  devise_for :users, controllers: {sessions: 'users/sessions'}

  root 'pages#landing'

  get 'pages/landing', as: 'welcome'

  get 'pages/contact', as: 'contact'

  get 'pages/faq', as: 'faq'

  resources :users, only: [:index]

  resources :profile, only: [:index, :edit, :update, :show, :destroy]

  resources :conversations, only: [:index, :show, :destroy] do

    collection do
      delete :empty_trash
    end

    member do
      post :restore
      post :reply
      post :mark_as_read
    end

  end

  resources :messages, only: [:new, :create]

  resources :commissions

  resources :user_stories, except: [:index]

  resource :cart, only: [:show]

  resources :order_items, only: [:create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
