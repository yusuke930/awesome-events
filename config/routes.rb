Rails.application.routes.draw do
  # get 'events/new'
  # get 'events/create'
  # get 'events/update'
  # get 'events/destroy'
  root 'welcome#index'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :retirements
  resources :users
  resources :events do
    resources :tickets
  end
  get 'status' => 'status#index', defaults: { format: 'json' } # as same as visiting /status.json
  # get '/auth/github' => '/auth/:provider/callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
