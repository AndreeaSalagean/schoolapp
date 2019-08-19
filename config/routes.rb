Rails.application.routes.draw do
  get 'discussions/indexedit'
  get 'discussions/show'
  get 'discussions/new'
  resources :submissions do
    match :grade, via: :post, on: :collection
  end
  resources :articles
  get 'resources/index'
  get 'resources/new'
  get 'resources/destroy'
  devise_for :users, :controllers => { :sessions => 'users/sessions' }
  # devise_scope :user dopost
  # end
  get 'index' => 'welcome#index' 
  get 'welcome/search_page'
  resources :users do
    match :create_user, via: :post, on: :collection
    collection do
      get :show_students
    end
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses do 
    match :create_course, via: :post, on: :collection
    match :add_student_course, via: :get, on: :collection
    match :add_teacher, via: :get, on: :collection
    match :enroll_student, via: :post, on: :collection
    match :update_course, via: :post, on: :collection
    match :show_teachers, via: :get, on: :collection
    match :update_owner, via: :get, on: :collection
    match :join_teachers, via: :get, on: :collection
    match :join_students, via: :get, on: :collection
    match :join_students_enroll, via: :post, on: :collection
    match :join_teacher_course, via: :post, on: :collection
    match :remove_from_course, via: :get, on: :collection
    match :show_course_enable, via: :get, on: :collection
    match :show_assignments, via: :get, on: :collection

    resources :chapters do

      resources :assignments do
        match :create_assignment, via: :post, on: :collection
      end
    end

  end

  resources :forums do
    resources :discussions do
      resources :replies 
    end
  end
  resources :resources, only: [:index, :new, :create, :destroy]   

  resources :schools do
    match :search_school, via: :post, on: :collection

  end
  
  post 'replies/create'
  post 'discussions/update'
  post 'discussions/create'
  post 'forums/create'
  post 'forums/update'
  post 'schools/create'
  post 'schools/update'
  root 'welcome#index'
end
