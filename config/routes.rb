Rails.application.routes.draw do
  root "employees#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :employees, except: :show do
    collection do
      get 'search'
    end
  end
end
