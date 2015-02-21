Rails.application.routes.draw do
root :to => 'questions#index'

#clean urls
get 'signup', to: 'users#new', as: 'signup'  
get 'login', to: 'sessions#new', as: 'login'
get 'logout', to: 'sessions#destroy', as: 'logout' 
 
#other
resources :users

resources :sessions #, :except => [:index, :show, :edit, :update ]
 
resources :questions do
   resources :answers
 end

resources :upvotes#, :except => [ :index, :show, :destroy ]


end
