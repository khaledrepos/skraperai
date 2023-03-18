Rails.application.routes.draw do
  
  
  resources :projects do 
    resources :resources, only: :index do
      get :ask, on: :collection
      post :create_bulk, on: :collection
    end
  end


  resource :playground, only: [:show] do
    post :simulate, on: :member
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"
end
