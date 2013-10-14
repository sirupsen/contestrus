Contestrus::Application.routes.draw do
  root 'session#new'

  resources :sessions, controller: 'session'
  resources :competitions, :users

  resources :tasks do
    resources :submissions
  end

  get 'sign_out' => 'session#sign_out'
end
