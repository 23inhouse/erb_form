TestApp::Application.routes.draw do
  match ':controller(/:action(/:id(.:format)))'
  resources :blogs
end
