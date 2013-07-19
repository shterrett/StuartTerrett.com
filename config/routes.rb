StuartTerrett::Application.routes.draw do
  
  resources :technologies
  
  resources :projects
  
  resources :employments
  get '/resume' => 'employments#index', as: :resume
  
  resources :contacts, only: [:new, :create]
  get '/contact-me' => 'contacts#new', as: :contact_me
  
  resources :abouts, only: [:show, :update]
  get '/about-me' => 'abouts#show', as: :about_me
  get '/about/edit' => 'abouts#edit', as: :about_edit
  
  get '/admin' => 'admin#admin', as: :admin
  get '/admin/technologies' => 'admin#technologies_index', as: :admin_technologies
  get '/admin/projects' => 'admin#projects_index', as: :admin_projects
  get '/admin/employments' => 'admin#employments_index', as: :admin_employments
  
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
