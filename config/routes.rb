Rails.application.routes.draw do


  ## STUB CRUD money transfer endpoints
  # we'll need to take into consideration
  # - transfer out CLABE
  #
  namespace :api do
    namespace :v1 do
      get 'money_transfers' => "money_transfer#index"
      get 'money_transfers/:id' => "money_transfer#show"
      post 'money_transfers' => "money_transfer#create"
      patch 'money_transfers/:id' => "money_transfer#update"
      delete 'money_transfers/:id' => "money_transfer#destroy"
    end
  end
  namespace :api do
    namespace :v1 do
      get 'users' => "user#index"
      get 'users/:id' => "user#show"
      post 'users' => "user#create"
      patch 'users/:id' => "user#update"
      delete 'users/:id' => "user#destroy"
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
