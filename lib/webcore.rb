# Load dependencies from gemspec so we don't need to mention in app's
Gem.loaded_specs['webcore'].dependencies.each do |d|
 require d.name
end

require "webcore/engine"
require "webcore/controller"

# Now monkey patch core stuff with our magic.
# so @article.created_at.mdy works  instead of mdy(@article.created_at)
require "webcore/core_extensions/time_with_zone"
#require "webcore/core_extensions/form_builder"

module Webcore
end
