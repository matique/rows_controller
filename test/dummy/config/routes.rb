Dummy::Application.routes.draw do
  resources :orders
  resource(:order) {
    resources(:items, controller: 'order/items')
  }
  resources :categories

  put '/rows_ext/:id/copy', to: 'orders#copy'
  delete '/rows_ext/multi_deletion', to: 'orders#multi_deletion'
  root :to => 'orders#index'
end
