Contestrus::Application.routes.draw do
  root "sessions#new"

  resource :sessions

  resources :competitions do
    member do
      get "leaderboard" => "competitions#leaderboard"
    end
  end
  
  resources :users

  resources :tasks do
    resources :submissions
  end

  get '/instructions' => 'pages#instructions', as: 'instructions'
end
