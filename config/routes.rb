Rails.application.routes.draw do
  devise_scope :user do
    authenticated  do
      root to: 'posts#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, except: [:index]
  end
  resources :comments, except: [:index] do
    resources :likes, only: [:create, :destroy]
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
