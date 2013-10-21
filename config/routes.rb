Contestrus::Application.routes.draw do
  get "pages/instructions"
  root 'session#new'

  resource :sessions, controller: 'session'

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
