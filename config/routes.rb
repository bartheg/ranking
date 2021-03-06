Rails.application.routes.draw do

  resources :calculated_positions, only: :index

  resources :ranking_configs, only: [:edit, :update]

  resources :reports, only: [:edit, :update]

  resources :reports do
    member do
      patch 'confirm'
    end
  end
  devise_for :users

  resources :users, only: [:index, :show]

  resources :users do
    resources :profiles, only: :index
    resources :reports, only: :index
  end

  resources :games do
    resources :rankings, only: [:index, :new, :create]
    resources :possible_results

  end

  resources :scenarios do
    resources :reports
  end

  resources :rankings do
    resources :scenarios, only: [:index, :new, :create]
    resources :calculated_positions, only: [:index]
    resources :ranking_configs, only: [:show, :new, :create, :edit, :update]

  end

  resources :reports, only: [:index, :edit, :update]


  get 'pages/home'
  get 'pages/how_it_works'

  get 'pages/admin'

  devise_scope :user do
    get 'install', to: 'new_super_admin#new'
    post 'create_super_admin', to: 'create_super_admin#create'
    # get 'sign_in', to: 'devise/sessions#new'
  end


  get 'pages/access_denied'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # get 'my_profiles' => 'profiles#index'

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :profiles do
    member do
      get :switch_to
    end
  end

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
