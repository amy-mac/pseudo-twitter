FinalApp::Application.routes.draw do
  resources :users
  root :to => 'static_pages#index'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

end
