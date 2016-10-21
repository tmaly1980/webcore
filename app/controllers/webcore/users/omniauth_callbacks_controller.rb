module Webcore
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])

      # abort @user.inspect

      if @user.persisted?
        sign_in @user

        redirect_to goto_path

        # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to goto_path
      end
    end

    def failure
      redirect_to goto_path
    end

    def omniauth_params
      return {} unless request.env['omniauth.params']
      request.env['omniauth.params']
    end

    def goto_path
      return root_path unless omniauth_params[:goto]
      omniauth_params[:goto]
    end
  end
end