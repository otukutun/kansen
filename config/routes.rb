Rails.application.routes.draw do
  root 'pages#top'

  get 'users/my'
  get 'users/index'
  resources :matches, only: :show

  devise_for :users, controllers: {
                       omniauth_callbacks: 'users/omniauth_callbacks',
                       sessions: 'users/sessions',
                       passwords: 'users/passwords',
                       confirmations: 'users/confirmations',
                       registrations: 'users/registrations',
                       unlocks: 'users/unlocks'
                   }
  devise_scope :user do
    get '/sign_in' => 'users/sessions#new'
    post 'sign_in' => 'users/sessions#create'
    delete '/sign_out' => 'users/sessions#new'
    get '/sign_up' => 'users/registrations#new'
    post '/sign_up' => 'users/registrations#create'
  end

  constraints Subdomain::Admin do
    namespace :admin, path: Subdomain::Admin.path do
      devise_for :admin_users, class_name: "Admin::AdminUser"
      root 'pages#index'
      #  devise_for :admin_user, controllers: {
      #                            #omniauth_callbacks: 'admin/omniauth_callbacks',
      #                            sessions: 'admin/sessions',
      #                            passwords: 'admin/passwords',
      #                            confirmations: 'admin/confirmations',
      #                            registrations: 'admin/registrations'
      #                            #unlocks: 'admin/unlocks'
      #                        }
    end
  end

  constraints Subdomain::Api do
    namespace :api, path: Subdomain::Api.path do
    end
  end
  # devise_scope :user do
  #  get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
  #  get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end

  # devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
