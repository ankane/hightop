# dependencies
require "active_support"

# modules
require "hightop/enumerable"
require "hightop/kicks"
require "hightop/version"

ActiveSupport.on_load(:active_record) do
  extend Hightop::Kicks
end
