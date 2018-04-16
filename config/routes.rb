Rails.application.routes.draw do
  resources :contacts
  root 'contacts#index'
  get '/contacts/page/:page', to: 'contacts#index'
end
