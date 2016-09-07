module Webcore
	module CoreExtensions
		module TimeWithZone
			def mdy
				strftime("%m/%d/%Y")
			end
		end
	end
end

ActiveSupport::TimeWithZone.include Webcore::CoreExtensions::TimeWithZone
