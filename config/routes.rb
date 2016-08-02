Rails.application.routes.draw do

	get 'users/user_list'
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
	get 'administration/topicos'
	get 'administration/eventos'
	get 'administration/links'

	get 'events/listado'

	resources :resources
	resources :organizations
	resources :finances
	resources :portals
	resources :administration, only: [:index]
	resources :contacts, only: [:index, :create]
	resources :events do
		resources :event_comments
	end
	resources :topics do
		resources :articles, except: [:index]
	end
	resources :articles do
		resources :comments
	end
	devise_for :users, :controllers => { :registrations => "users/registrations"}
	resources :users, only: [:index, :show, :edit, :update]

	resources :interest_links, except: [:index, :show]

	root 'portals#index'

end
