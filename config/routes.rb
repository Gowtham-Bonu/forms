Rails.application.routes.draw do
  root "employees#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get "/search_employee" => "employees#search", as: "search"
  resources :employees
end
