module Concerns
        module UserRecord
                extend ActiveSupport::Concern

                included do
                        belongs_to :user
                        before_save :assign_user
                end

                private
                def assign_user(record)
                        record.user_id = current_user.id
                end
        end
end
