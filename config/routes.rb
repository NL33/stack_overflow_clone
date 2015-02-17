Rails.application.routes.draw do
root :to => 'users#index'
resources => :users
#clean urls
get 'signup', to: 'users#new', as: 'signup'  
get 'login', to: 'sessions#new', as: 'login'
get 'logout', to: 'sessions#destroy', as: 'logout' 
 
#other

 resources => :questions
 resources => :answers

 resources :sessions, :except => [:index, :show, :edit, :update ]
 

end
