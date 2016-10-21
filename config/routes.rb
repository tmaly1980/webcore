Webcore::Engine.routes.draw do
	#get "/users/omniauth_callbacks", to: "users/omniauth_callbacks#passthru"
	

	post "/page_photos/:id/caption", to: "page_photos#caption"

	resources :page_photos, path: '/page_photos'

	# ...
end
