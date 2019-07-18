Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => 'users/sessions' }
  # devise_scope :user do
  # end
  get 'welcome/index'
  resources :users do
    match :create_user, via: :post, on: :collection
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :schools do
    match :search_school, via: :post, on: :collection
  end
  post 'schools/create'
  root 'welcome#index'
end
