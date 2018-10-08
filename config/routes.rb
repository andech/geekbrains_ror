Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users
  resources :posts

  root 'home#index'
  get 'home(/:hello)', to: 'home#index'
  get 'posts/page/(:page(.:format))', to: 'posts#index'
  get 'posts/:id/comments/(:page)', to: 'posts#show'
  get 'poetry', to: 'home#poetry'

  match '/users/:id/finish_signup', to: 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :omni_destroy_user_session
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
