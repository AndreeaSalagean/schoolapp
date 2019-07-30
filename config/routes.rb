Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => 'users/sessions' }
  # devise_scope :user do
  # end
  get 'welcome/index'
  resources :users do
    match :create_user, via: :post, on: :collection
    collection do
      get :show_students
    end
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses do 
    match :create_course, via: :post, on: :collection
    match :edit_teacher_course, via: :get, on: :collection
    match :add_student_course, via: :get, on: :collection
    match :add_teacher, via: :post, on: :collection
    match :add_student, via: :post, on: :collection
    match :update_course, via: :post, on: :collection
end

  resources :schools do
    match :search_school, via: :post, on: :collection
  end
  
  post 'schools/create'
  root 'welcome#index'
end
