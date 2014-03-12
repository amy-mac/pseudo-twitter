FinalApp::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :tweets, except: [:index]

  resources :sessions, only: [:new, :create, :destroy]

  resources :relationships, only: [:create, :destroy]

  root :to => 'static_pages#index'


  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

end
