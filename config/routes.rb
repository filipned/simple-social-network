Rails.application.routes.draw do

  mount Simple::API => '/'


  #ROOT<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    root 'users#log_in_view', as: 'log_in_view'

  #   TODO izdvojiti posebnu klasu Auth za trenutno ulogovanog usera
  #AUTH<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    post 'log_in' => 'users#log_in', as: 'log_in'
    get 'log_out' => 'users#log_out', as: 'log_out'

  #FRIENDSHIPS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    get 'friendships' => 'friendships#index', as: 'friends'
    post 'friendships' => 'friendships#create', as: 'friendship_create'
    patch 'friendships/accept' => 'friendships#accept', as: 'friendship_accept'
    delete 'friendships/destroy' => 'friendships#destroy', as: 'friendship_destroy'

  #USERS/POSTS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    resources :users do
      resources :posts
    end

  #POSTS/COMMENTS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    resources :posts do
      resources :comments
    end
   


  # Example resource route with options:
  # resources :products do
  #   member do
  #     get 'short'
  #     post 'toggle'
  #   end

  #   collection do
  #     get 'sold'
  #   end
  # end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (Blog/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
