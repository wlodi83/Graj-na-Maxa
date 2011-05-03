Serialki::Application.routes.draw do
  resources :age_brackets
  resources :subscriptions, :only => [:index]
  match 'subscription/add_subscription/:id' => 'subscriptions#add_subscription', :as => :add_subscription 
  match 'subscription/remove_subscription/:id' => 'subscriptions#remove_subscription', :as => :remove_subscription
  resources :ratings
  resources :categories do
    resources :games
  end
  match 'games/add_tags_div' => "games#add_tags_div", :as => 'add_tags_div'
  match 'games/remove_tags_div' => "games#remove_tags_div", :as => 'remove_tags_div'
  devise_for :users
  resources :users, :only => [:index, :show]
  match 'user/add_admin/:id' => 'users#add_admin', :as => :add_admin
  match 'user/remove_admin/:id' => 'users#remove_admin', :as => :remove_admin
  match 'games/admin' => 'games#admin'
  match 'games/list_your_games' => 'games#list_your_games'
  resources :comments, :only => [:destroy, :index]
  match 'search/query' => 'search#search', :as => 'search'
  match 'search/add_advanced' => 'search#add_advanced', :as => 'add_advanced_search'
  root :to => "games#index"
  resources :games do
    resources :comments
    collection do
      get :tag
    end
    member do
      post :notify_friend
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
