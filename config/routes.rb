# coding: utf-8
ChinaWhere::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  root to: 'welcome#index'
  post 'geo', to:'welcome#geo'
  post 'show_events', to:'welcome#show_events'
  get 'test', to: 'welcome#test', as: :test
  scope controller: :sessions do
    get :login
    get :register
    get :logout
    post :sessions
    post :sign_up
  end

  # mount Twitter::API => '/'

  get 'home', to: 'home#index', as: :home

  resources :setting, as: :settings, only: [] do
    collection do
      get :account
      put :basic
      patch :basic
      get :password
    end
  end

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

  resources :taxons, only:[] do
    member do
      get :list
    end
  end

  namespace :admin do
    root to: "sessions#index"
    scope controller: :sessions do
      get :login
      get :logout
      post :sessions
      post :set_tab
    end

    resources :users

    resources :roles

    resources :events

    resources :applies

    resources :question_classifies

    resources :questions

    resources :slide_ads

    resources :taxons do
      collection do
        post :position
      end
      resources :sub_menus
    end

  end

  resources :cities do
    member do
      post 'pick'
    end
    collection do
      get 'select'
    end
  end

  resources :trade do
    member do
      post 'pick'
    end
    collection do
      get 'index'
      get 'get_access_token'
      get 'get_weixin_ip'
      get 'get_all_user_name'
      get 'lzj'
      post 'lzj'
      get 'native'
      post 'native'
      get 'notify_url'
      post 'notify_url'
    end
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
