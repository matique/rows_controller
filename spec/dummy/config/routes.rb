Dummy::Application.routes.draw do
  resources :orders do
    get 'copy', :on => :member
  end
  resources :categories
  root :to => 'orders#index'
end
