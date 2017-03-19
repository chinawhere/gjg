# coding: utf-8
ChinaWhere::Application.routes.draw do
  root to: 'welcome#index'

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
    resources :enlists

    resources :players

    resources :users

    resources :roles

    resources :events

    resources :gensees


  end
end
