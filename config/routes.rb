Geoevents::Application.routes.draw do
  
  resources :users, :except => :show 

  resources :applications do
  	resources :pushers	
  end

  root :to => "home#index"

  devise_for :users

end
