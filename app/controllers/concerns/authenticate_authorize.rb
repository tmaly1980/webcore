module Concerns
	module AuthenticateAuthorize
		extend ActiveSupport::Concern

		included do
		  #before_action :authenticate_and_authorize!

		  def authenticate_and_authorize!
		  	logger.debug private_methods.join(";")

		    if private_methods.try(:include?, params[:action]) || private_methods.try(:include?, '*')
		      authenticate_user! # devise auth
		    end

		    if !is_authorized?
		      redirect_to "/", alert: "Sorry, you're not allowed to do that"
		    end
		  end

		  # For now, assume there are admins and non-admins
		unless method_defined? is_authorized?
			  define_method :is_authorized? do # Per controller/action, check current_user.admin? etc
			    if admin_methods.try(:include?, params[:action]) || admin_methods.try(:include?, '*')
			      current_user.try(:admin?) || current_user.try(:manager?)
			    end
			    true
			  end
		end

		unless method_defined? :private_methods
			logger.debug "POO PRIVATE"
		  define_method :private_methods do # If specific controller wants to block something else, it can alter.
		      ['new','delete','destroy','edit','create']
		  end
		end

		unless method_defined? :admin_methods
		  define_method :admin_methods do # Define per controller; Only admins (NOT volunteers) can go here
		    []
		  end
		end

			
		end

		module ClassMethods
		end
	end
end