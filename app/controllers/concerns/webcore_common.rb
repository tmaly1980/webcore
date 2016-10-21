module Concerns
	module WebcoreCommon
		extend ActiveSupport::Concern

		included do
			# DOESNT SEEM TO BE LOADING... mhmmm
			
			# # Trace redirects, for infinite looping issues
			# def redirect_to(options = {}, response_status = {})
			#   ::Rails.logger.error("Redirected by #{caller(1).first rescue "unknown"}")
			#   super(options, response_status)
			# end
		  
		end

		module ClassMethods
		end
	end
end