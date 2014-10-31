Dummy::Application.routes.draw do
  resources :orders
  resources :categories

  put '/rows_ext/:id/copy', to: 'orders#copy'
  delete '/rows_ext/multi_deletion', to: 'orders#multi_deletion'
  root :to => 'orders#index'
end
