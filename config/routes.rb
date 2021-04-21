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
  #devise_for :users

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
                 sign_in: 'api/login',
                 sign_out: 'api/logout',
                 #registration: 'api/signup'
                 # we're disabling the public signup page
                 # only ADMIN can create user
             },
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
             }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
