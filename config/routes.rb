# coding: utf-8
ChinaWhere::Application.routes.draw do

  post "weixin/topics"

  get "weixin/test"

  post "weixin/index"

  get "weixin/code"

  post "weixin/register"

  root to: 'welcome#index'
  get 'test', to: 'welcome#test', as: :test
  scope controller: :sessions do
    get :login
    get :register
    get :logout
    post :sessions
    post :sign_up
  end
  
  mount Twitter::API => '/'

  get 'home', to: 'home#index', as: :home

  resources :setting, as: :settings, only: [] do
    collection do
      get :account
      put :basic
      get :password
    end
  end

  resources :articles
  resources :events do
    member do
      get :uploader
      get :photos
      get :apply_event
      get :not_apply_event
    end
    collection do
      get :calendar
    end
  end
  resources :photos, only: [:create, :destroy] do
    member do
      get :show_original
      put :recommend
    end
  end

  resources :comments, only:[:index, :create, :destroy] do
    collection do
      post :destroy_comment
    end
  end

  namespace :admin do
    root to: "sessions#index"
    scope controller: :sessions do
      get :login
      get :logout
      post :sessions
    end

    resources :users

    resources :roles

    resources :events

    resources :applies
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
