Rails.application.routes.draw do
  resources :orders
  namespace :order do
    resources :items
  end

  put '/rows_ext/:id/copy', to: 'orders#copy'
  delete '/rows_ext/multi_deletion', to: 'orders#multi_deletion'
end
