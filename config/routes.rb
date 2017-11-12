Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'index#index'
  get '/init', to: 'index#init'
  post '/init', to: 'index#do_init'

  get '/dashboard', to: 'dashboard#dashboard'
end
