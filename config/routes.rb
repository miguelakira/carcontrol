Carcontrol::Application.routes.draw do
 

  get "clientes/index"

  # resources :cegonhas
  get "cars/new"
  get "search/index"
  get "cars/inativos"
  get "cars/editar_localizacao"
  
  resources :compradores
  resources :cars do
    get :limited_edit
  end

  resources :cegonhas
  resources :parceiros
  devise_for :users, :path_prefix => 'd'
  resources :users
  resources :clientes
  match ':controller(/:action(/:id))(.:format)'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  
  root :to => 'clientes#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
