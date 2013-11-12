Shareup::Application.routes.draw do
  scope '/api' do
    resources :shares

    devise_for :users,
      :controllers => {
        omniauth_callbacks: "users/omniauth_callbacks",
        registrations: "users/registrations",
        sessions: "users/sessions"
      }

    devise_scope :user do
      post '/check/is_user' => 'users/users#is_user', as: 'is_user'
      post '/current_user' => 'users/sessions#get_current_user'
    end
  end
  get '/dashboard' => 'welcome#dashboard'
  root to: 'welcome#index'
end
