Rails.application.routes.draw do
	default_url_options :host => "example.com"

	devise_for :users, path: '',
	 controllers: {
			 registrations: 'registrations',
			 omniauth_callbacks: 'users/omniauth_callbacks'
	 }

	get '/users/developers', to: 'users#index', as: :developers

	resources :users, only: [:show, :edit, :update, :index]

	resources :conversations, only: [:index, :create] do
		resources :messages, only: [:index, :new, :create]
	end

	resources :projects, only: [:show, :index, :new, :create, :edit, :update]

	# root to: 'static#home'
	root to: redirect("/sign_in")

	get '/welcome', to: 'static#welcome'


	# routes
	# new_user_session 				GET    /sign_in(.:format)       devise/sessions#new
	# user_session 						POST   /sign_in(.:format)       devise/sessions#create
	# destroy_user_session 		DELETE /sign_out(.:format)      devise/sessions#destroy
	# new_user_registration 	GET    /sign_up(.:format)       registrations#new

end
