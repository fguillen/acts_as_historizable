ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'tasks'
  
  map.resources :tasks do |tasks|
    tasks.resources :histories
  end

end
