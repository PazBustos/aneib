Rails.application.routes.draw do

  resources :interest_links
  get 'portals/somos'
  get 'portals/coneib'
  get 'portals/estatuto'
  get 'portals/socio'
  get 'portals/newSomos'
  get 'portals/newConeib'
  get 'portals/newNotice'
  get 'portals/newEstatuto'
  get 'portals/newSocio'

  get 'administration/somos'
  get 'administration/coneib'
  get 'administration/estatuto'
  get 'administration/socio'
  get 'administration/noticias'
  get 'administration/galeria'
  get 'administration/cuentas'
  get 'administration/organizacion'
  get 'administration/recursos'

  resources :resources
  resources :organizations
  resources :finances
  resources :events
  resources :contacts, only: [:index, :create]
  resources :portals
  resources :topics do
    resources :articles
  end
  resources :administration, only: [:index]
  resources :articles do
    resources :comments
  end

  devise_for :users, :controllers => { :registrations => "users/registrations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'portals#index'

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
