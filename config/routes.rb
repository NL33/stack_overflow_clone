Rails.application.routes.draw do
root :to => 'questions#index'
resources :users
#clean urls
get 'signup', to: 'users#new', as: 'signup'  
get 'login', to: 'sessions#new', as: 'login'
get 'logout', to: 'sessions#destroy', as: 'logout' 
 
#other

 resources :questions do
    resources :answers
  end

 resources :sessions, :except => [:index, :show, :edit, :update ]
 

end
