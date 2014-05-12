Rails.application.routes.draw do

  namespace :v1 do
    match '*path', to: 'application#handle_options_request', via: [:options]
    resources :categories, only: [:index]
    resources :expenses, only: [:show, :create]
  end
end
