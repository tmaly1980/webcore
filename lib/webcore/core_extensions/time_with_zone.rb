module Webcore
	module CoreExtensions
		module TimeWithZone
			def md # year only if different
				format = "%m/%d" # 3/22/2012
				format += "/%Y" if(self.year != Date.today.year)
				strftime(format)
			end
			def mdy
				strftime("%m/%d/%Y")
			end
			
			def mond # year only if different
				format = "%b %-d" # Jan 26, 2010
				format += " %Y" if(self.year != Date.today.year)
				strftime(format)
			end
			def mondy
				strftime("%b %-d %Y")
			end
		end
	end
end

ActiveSupport::TimeWithZone.include Webcore::CoreExtensions::TimeWithZone
