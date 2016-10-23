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

			before_action :persistSessions

			def persistSessions # In between sign-ins, keep same session_id
				Warden::Manager.after_set_user do |user,auth,opts| # Needs to be in callback, since warden sets
  					auth.env["rack.session.options"][:renew] = false # Keep session_id after sign_in
  					# auth.env["rack.session.options"][:try_again] = Time.new.to_f
				end
			end
		  
		end

		module ClassMethods
		end
	end
end