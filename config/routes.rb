Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'site#index'
  # get '*path' => 'site#index'
  #   constraints: /^\/api\/.*$/

  # oAuth Routes
  # get 'auth/logout' => 'auth#logout'
  get 'auth/failure' => 'auth#failure'
  get 'auth/:provider/callback' => 'auth#callback'


  # The following routes will all be API only routes. They will only return
  # a json object and will not render pages.
  scope '/api', defaults: {format: :json} do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    get 'check' => 'sessions#check'
    delete 'logout' => 'sessions#destroy'
    # get 'logout' => 'sessions#destroy'

    resources :tools do
        resources :tvotes, :only => [:create,:destroy]
        resources :reviews, :only => [:create,:update,:destroy]
    end
    resources :users do
        resources :tool, :only => [:create,:destroy]
    end
    resources :tags, :only => [:create]
  end

  root to: 'site#index'#, anchor: false
  match '*path' => 'site#index', via: :all

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products



  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

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
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
