GPinch::Application.routes.draw do
  # Showing reviews
  get "jobs/:job_id/review/:photo_id", to: "jobs#review", as: :show_review
  # stripe events
  resources :stripe_events, only: [:create]
  #sales with stripe
  resources :sales, only: [:index, :show]
  #stripe links
  get '/hire/:user_id', to: 'transactions#new', as: :show_hire 
  post'/hire/:user_id',to:'transactions#create', as: :hire 
  get'/pickup/:guid', to:'transactions#pickup', as: :pickup
  #call to accept, reject, view and complete job on portfolio
  match "jobs/:job_id/accept" => "jobs#accept", via: :get, :as => "accept_job"
  match "jobs/:job_id/reject" => "jobs#reject", via: :get, :as => "reject_job"
  match "jobs/:job_id/view" => "jobs#view", via: :get, :as => "view_job"
  match "jobs/:job_id/complete" => "jobs#complete", via: :get, :as => "complete_job"
  # Static pages
  get "about" => 'welcome#about'
  get "gallery" => 'portfolios#gallery'
  # paths for models
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users, only: [:update]
  resources :portfolios do 
    resources :photos do 
      resources :comments, only: [:create, :destroy], :defaults => { :commentable => 'photo' }
    end
  end
  resources :profile
  
  resources :jobs, only: [:index, :new, :show, :create, :destroy] do 
    resources :pinches, only: [:create, :destroy]
  end
  # Change root path if user is authenticated
  authenticated :user do
    root to: "jobs#index", :as => "authenticated_root"
  end
  root to: 'welcome#index'

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
