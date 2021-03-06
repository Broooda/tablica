Rails.application.routes.draw do
  
  root 'week#showtime'

  devise_for :users
  resources :users
  get 'users/accept/:id' => 'users#accept', as: "user_accept"
  get 'users/makeadmin/:id' => 'users#make_admin', as: "make_admin"
  get 'users/unmakeadmin/:id' => 'users#unmake_admin', as: "unmake_admin"

  
  get 'week/time' => 'week#showtime'
  get 'week/time/:year/:week' => 'week#showtime', as: "week_time_date"
  get 'week/time/:fulldate' => 'week#showtime', as: "week_time_fulldate"
  get 'week/people' => 'week#showpeople'
  get 'week/people/:fulldate' => 'week#showpeople', as: "week_people_fulldate"
  get 'week/people/:year/:week' => 'week#showpeople', as: "week_people_date"

  get 'stand_up' => 'scrum_meetings#index', as: "scrum_meeting"
  get 'ajax/stand_up/show' => 'scrum_meetings#show', as: "scrum_meeting_ajax"

  get 'default_work_times/generate' => 'default_work_times#generate_few_weeks', as: "generate_hours_plans"
  get 'raports/generate_email' => 'raports#generate_email', as: "generate_email"
  resources :default_work_times, only: [:show]
  get 'default_work_times/accept/:id' => 'default_work_times#accept', as: "default_work_time_accept"
  get 'default_work_times/reject/:id' => 'default_work_times#reject', as: "default_work_time_reject"
  

  resources :default_work_times_request, only: [:destroy]
  match "delete" => "default_work_times_request#destroy", :via => :delete

  resources :holidays
  get 'holidays/accept/:id' => 'holidays#accept', as: "holiday_accept"
  get 'holidays/reject/:id' => 'holidays#reject', as: "holiday_reject"
  
  resources :inboxs, only: [:index]

  post 'update_work_time' => 'default_work_times#update_work_time', as: :update_work_time
  get 'manual_generate' => 'inboxs#manual_generate', as: :manual_generate
  post 'manual_generate_post' => 'inboxs#manual_generate_post', as: :manual_generate_post


  resources :raports, only: [:index, :pdf_view, :new, :create]#:history]

  get 'pdf_view' => 'raports#pdf_view', as: :pdf_view
  get 'pdf_admin_view' => 'raports#pdf_admin_view', as: :pdf_admin_view
 
  #get 'pdf_view_test' => 'raports#pdf_view_test', as: :pdf_view_test

  #get 'take_day' => 'raports#take_day', as: :take_day


  resources :hours_plans

  resources :over_hours
  post 'accept/:id' => 'over_hours#accept', as: :over_accept
  post 'reject/:id' => 'over_hours#reject', as: :over_reject

  get 'layouts/pdfgen' =>'users#index', as: "generate_pdf"



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
