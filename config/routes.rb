Rails.application.routes.draw do
  get 'home/index'
  post 'home/file_upload'
  root 'home#index'
  get 'home/orders'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
