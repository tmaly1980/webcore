module Concerns
	module AuthenticateAuthorize
		extend ActiveSupport::Concern

		included do
		  before_action :authenticate_and_authorize!

		  def authenticate_and_authorize!
		    if private_methods.try(:include?, params[:action])
		      authenticate_user! # devise auth
		    end

		    if !is_authorized?
		      redirect_to "/", alert: "Sorry, you're not allowed to do that"
		    end
		  end

		  # For now, assume there are admins and non-admins
		  define_method :is_authorized? do # Per controller/action, check current_user.admin? etc
		    if admin_methods.try(:include?, params[:action])
		      current_user.try(:admin?) || current_user.try(:manager?)
		    end
		    true
		  end

		  define_method :private_methods do # If specific controller wants to block something else, it can alter.
		      ['new','delete','destroy','edit','create']
		  end

		  define_method :admin_methods do # Define per controller; Only admins (NOT volunteers) can go here
		    []
		  end

			
		end

		module ClassMethods
		end
	end
end