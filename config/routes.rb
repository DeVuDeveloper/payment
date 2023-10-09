Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  devise_for :users, path: "account", path_names: {
                       sign_in: "login",
                       sign_out: "logout",
                       password: "reset_password",
                       registration: "register",
                     }

  root "products#index"

  namespace :admin do
    resources :users
    resources :push_notifications do
      post "send_notification", on: :member
      post "subscribe", on: :collection
    end
    resources :products
  end

  resources :products do
    collection do
      post :create_product_ids
      get :cart_products
    end
    post :add_to_cart, on: :member

  end

  post 'products/add_to_cart'
  post 'products/remove_from_cart'
  
  get "/verify" => "verify#edit", :as => "verify"
  get "/verify" => "verify#new", :as => "new_verify"
  put "/verify" => "verify#update", :as => "update_verify"
  post "/verify" => "verify#create", :as => "resend_verify"
end
