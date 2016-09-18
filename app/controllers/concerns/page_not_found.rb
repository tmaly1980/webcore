module Concerns
	module PageNotFound
		extend ActiveSupport::Concern

		included do
		  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

			def record_not_found
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