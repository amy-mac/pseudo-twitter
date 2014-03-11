FinalApp::Application.routes.draw do
  resources :users do
    resources :tweets, except: [:index]
  end
  resources :sessions, only: [:new, :create, :destroy]

  root :to => 'static_pages#index'


  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

end
