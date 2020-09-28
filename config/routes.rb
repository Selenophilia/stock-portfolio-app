Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
   }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root controller: :stock, action: :index


  resources :users, only: [:new, :create] do
    resources :transaction, only: [:new, :create, :index]
    resources :stock, only: [:index]
  end

end
