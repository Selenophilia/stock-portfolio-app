Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
   }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root controller: :stock, action: :index

  get '/users/:user_id/stock' => 'stock#index', as: 'user_stock_index'
  get '/users/:user_id/transaction' => 'transaction#index', as: 'user_transaction_index'
  get '/users/:user_id/transaction/new'=> 'transaction#new',  as:'new_user_transaction' 
  post '/users/:user_id/transaction'=> 'transaction#create',  as: 'user_transaction'


end
