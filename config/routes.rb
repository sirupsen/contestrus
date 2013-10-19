Contestrus::Application.routes.draw do
  root 'session#new'

  resources :sessions, controller: 'session'
  resources :competitions do
    member do
      get "leaderboard" => "competitions#leaderboard"
    end
  end
  
  resources :users

  resources :tasks do
    resources :submissions
  end

  get 'sign_out' => 'session#sign_out'
end
