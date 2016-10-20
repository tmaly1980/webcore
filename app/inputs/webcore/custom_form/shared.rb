module Webcore
module CustomForm
	module Shared

		# redefine base 
		def input_html_classes
			super.push(options[:class]) if options[:class]
			super # Need super regardless!
		end	

	end
end
end
