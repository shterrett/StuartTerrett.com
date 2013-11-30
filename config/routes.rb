StuartTerrett::Application.routes.draw do

  get '/technologies/tokens' => 'technologies#tokens'
  get '/projects/tokens' => 'projects#tokens'

  resources :technologies, only: [:index, :show]
  resources :projects, only: [:index, :show]
  resources :employments, only: [:index, :show]
  resource :about, only: [:show]

  resource :admin, only: [:show]
  namespace :admin do
    resources :technologies,
      only: [:index, :new, :create, :edit, :update]
    resources :projects,
      only: [:index, :new, :create, :edit, :update]
    resources :employments,
      only: [:index, :new, :create, :edit, :update]
    resource :about, only: [:edit, :update]
  end

  get '/resume' => 'employments#index', as: :resume

  resources :contacts, only: [:new, :create]
  get '/contact-me' => 'contacts#new', as: :contact_me

  get '/about-me' => 'abouts#show', as: :about_me

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  root 'abouts#show'
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
