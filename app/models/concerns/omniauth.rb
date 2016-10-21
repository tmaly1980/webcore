module Concerns
        module Omniauth
                extend ActiveSupport::Concern

                included do
                end

                module ClassMethods
                        def from_omniauth(auth)
                                #abort auth.inspect

                                where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
                                        user.email = auth.info.email
                                        user.password = Devise.friendly_token[0,20]
                                        user.name = auth.info.name   # assuming the user model has a name
                                        user.image_url = auth.info.image # assuming the user model has an image
                                end
                        end
                        
                        def new_with_session(params, session)
                                super.tap do |user|
                                        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
                                                user.email = data["email"] if user.email.blank?
                                        end
                                end
                        end
                end
        end
end
