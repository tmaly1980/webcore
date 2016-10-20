module Webcore
  class Engine < ::Rails::Engine
    isolate_namespace Webcore

    initializer "action_mailer_auto_url_options.controller" do |app|
      ActionController::Base.send :include, Webcore::Controller
    end

	initializer "webcore.assets.precompile" do |app|
    		config.assets.precompile += %w( webcore/*.png )
		# WE NEED TO MENTION images here because images from engines dont get copied to /public unless implied via CSS
	end
	initializer :append_migrations do |app|
      		unless app.root.to_s.match root.to_s
                        config.paths["db/migrate"].expanded.each do |expanded_path|
                                app.config.paths["db/migrate"] << expanded_path
                        end
      		end
    	end

  end
end
