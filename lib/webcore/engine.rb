module Webcore
  class Engine < ::Rails::Engine
    isolate_namespace Webcore

	initializer "webcore.assets.precompile" do |app|
    		config.assets.precompile += %w( webcore/*.png )
		# WE NEED TO MENTION images here because images from engines dont get copied to /public unless implied via CSS
	end

  end
end
