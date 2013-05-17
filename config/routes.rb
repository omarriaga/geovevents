Geoevents::Application.routes.draw do
  resources :applications

  root :to => "home#index"

  devise_for :users

end
