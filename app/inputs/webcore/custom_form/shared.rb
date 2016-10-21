module Webcore
module CustomForm
	module Shared
		# OK input here is just the b.input inside the wrapper...
		# perhaps class in wrapper can be a proc?

		# def input(wrapper_options = nil) # convert 'div' to wrapper_html: { class: FOO }
		# 	wrapper_options = [] unless wrapper_options
		# 	wrapper_options[:wrapper_html] = { class: 'greenbg' }
		# 	return wrapper_options.inspect
		# 	# if wrapper_options.try(:div)
		# 	# 	wrapper_options = [] unless wrapper_options
		# 	# 	wrapper_options[:wrapper_html] = [] unless wrapper_options.try(:wrapper_html)
		# 	# 	wrapper_options[:wrapper_html][:class] = '' unless wrapper_options[:wrapper_html].try(:class)
		# 	# 	wrapper_options[:wrapper_html][:class] += ' '+wrapper_options[:div]
		# 	# end

		# 	super(wrapper_options)
		# end

		# redefine base 
		def input_html_classes # 'class' for inputs
			super.push(options[:class]) if options[:class]
			super # Need super regardless!
		end	
	end
end
end
