module Concerns
	module Sortable
		extend ActiveSupport::Concern

		included do
			def sort # JSON
				
			    respond_to do |format|
			      format.html {
			        if params[:action] != 'index' # Got to index page if possible
			          redirect_to url_for({action: 'index'}), alert: "Page not found: "+request.fullpath
			        else
			          render 'webcore/not_found'
			        end
			      }
			      format.json {
			        render json: { error: "Not found" }
			      }
			    end
		  	end
		  
		end

		module ClassMethods
		end
	end
end