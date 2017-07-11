# coding: utf-8
ChinaWhere::Application.routes.draw do
  root to: 'welcome#index_new'
  get '/test', to: 'welcome#index'
  get 'welcome/info_edit'
  
  scope controller: :sessions do
    get :login
    get :register
    get :logout
    post :sessions
    post :sign_up
    get :yun_callback
  end

  namespace :admin do
    root to: "sessions#index"
    scope controller: :sessions do
      get :login
      get :logout
      post :sessions
      post :set_tab
    end
    resources :enlists do 
      collection do
        get :export_csv
      end
      member do
        get :auditing_one
        get :auditing_two
      end
    end

    resources :players do
	   collection do
		   get :export_csv
	   end
    end

    resources :users

    resources :roles

    resources :events

    resources :gensees do
	    collection do
		    get :export_csv
	    end
    end

    resources :contents

  end
end
