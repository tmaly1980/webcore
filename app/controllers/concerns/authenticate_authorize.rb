module Concerns
	module AuthenticateAuthorize
		extend ActiveSupport::Concern

		included do
		  before_action :authenticate_user!, :if => :restricted_methods?
		  authorize_resource :only => [:show, :create, :new, :store, :update, :destroy], :if => :restricted_resource? # Allow other actions done by anyone, or call authorize! manually


			# Override user_methods => super - ['new','create'] # Will allow new/create for anonymous
			define_method :user_methods do # If specific controller wants to block something else, it can alter.
			      ['new','delete','destroy','edit','create'] # anon read ok, user only edit
			end

			define_method :admin_methods do # Define per controller; Only admins (NOT volunteers) can go here
			    []
			end			
			define_method :manager_methods do # Define per controller; Only managers can do this
			    []
			end

			define_method :admin_methods? do
				current_user.try(:admin?) ? admin_methods : []
			end			

			define_method :manager_methods? do
				current_user.try(:manager?) ? manager_methods : []
			end

			define_method :restricted_methods do # Override in app_controller
				user_methods + admin_methods? + manager_methods?
			end

			define_method :restricted_methods? do
				restricted_methods.try(:include?, params[:action]) || restricted_methods.try(:include?, '*')
			end

			define_method :restricted_resource? do
				 !static_controller? && restricted_methods?
			end # static_controller? declared in webcore::common

			
		end

		module ClassMethods
		end
	end
end
