require "webcore/engine"

# Now monkey patch core stuff with our magic.
# so @article.created_at.mdy works  instead of mdy(@article.created_at)
require "webcore/core_extensions/time_with_zone"

module Webcore
  # Your code goes here...

end
