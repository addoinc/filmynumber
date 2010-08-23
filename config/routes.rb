ActionController::Routing::Routes.draw do |map|  
  map.resources(
    :movies,
    :member => {
      :seen => :put, :watchable => :put,
      :watchable_twice => :put, :watchable_multi => :put
    },
    :collection => { :series => :get }
  )
  map.resources :users
  map.resource :user_session
  map.resource :account, :controller => "users"
  
  map.home '', :controller => 'movies', :action => 'index'
end
