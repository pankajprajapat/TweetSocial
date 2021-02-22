Rails.application.routes.draw do
  devise_scope :user do
    authenticated  do
      root to: 'posts#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
  concern :attachable do
    resources :attachments, only: :create
  end
  
  resources :posts, concerns: [:attachable]
  resources :comments, concerns: [:attachable]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
