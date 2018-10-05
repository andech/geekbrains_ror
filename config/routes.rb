Rails.application.routes.draw do
  resources :users
  resources :posts

  root 'home#index'
  get 'home(/:hello)', to: 'home#index'
  get 'posts/page/(:page(.:format))', to: 'posts#index'
  get 'posts/:id/comments/(:page)', to: 'posts#show'
  get 'poetry', to: 'home#poetry'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
