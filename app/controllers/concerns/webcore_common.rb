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
			before_action :store_goto

			def persistSessions # In between sign-ins, keep same session_id
				Warden::Manager.after_set_user do |user,auth,opts| # Needs to be in callback, since warden sets
  					auth.env["rack.session.options"][:renew] = false # Keep session_id after sign_in
  					# auth.env["rack.session.options"][:try_again] = Time.new.to_f
				end
			end

			def store_goto
				session[:goto] = params[:goto] if params[:goto]
			end

			def redirect_back_or_default(default)
			  session[:goto] || root_path
			end

			def after_sign_in_path_for(resource_or_scope) # sign_up and sign_in
			  redirect_back_or_default(resource_or_scope)
			end			
			def after_sign_up_path_for(resource_or_scope) # sign_up and sign_in
			  redirect_back_or_default(resource_or_scope)
			end		

			define_method :static_controller? do # Overwritten 'true' if not resource based for load_resource
				devise_controller?
			end
		  
		end

		module ClassMethods
		end
	end
end