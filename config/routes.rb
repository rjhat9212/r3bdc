R3bdc::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users

  #Restful API providing access to the users
  namespace :rest do
    namespace :secure do
      namespace :v1 do
        resource :users, :defaults => { :format => 'json' }
      end
    end
    namespace :v1 do
      resources :users , :defaults => { :format => 'json' }
    end
  end
end
