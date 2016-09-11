module Webcore
  class Engine < ::Rails::Engine
    isolate_namespace Webcore

    #config.assets.paths << File.expand_path("../../../app/assets/images", __FILE__)
    #config.assets.precompile += %w( images/webcore/* )
    #
    #config.assets.paths << File.expand_path("../../../app/assets/images/webcore", __FILE__)
    #config.assets.precompile += %w( *.png )

    initializer :assets do |config|
    	STDERR.puts "POO! =)"
    	#Rails.application.config.assets.paths << root.join("app","assets","images")

	STDERR.puts "RP2="
	STDERR.puts Rails.application.config.assets.paths

    end

  end
end
