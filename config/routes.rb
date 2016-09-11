Webcore::Engine.routes.draw do
	post "/page_photos/:id/caption", to: "page_photos#caption"

	resources :page_photos, path: '/page_photos'

end
