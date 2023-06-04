# dependencies
require "active_support"

# modules
require_relative "hightop/enumerable"
require_relative "hightop/version"

ActiveSupport.on_load(:active_record) do
  require_relative "hightop/utils"
  require_relative "hightop/kicks"
  extend Hightop::Kicks
end

ActiveSupport.on_load(:mongoid) do
  require_relative "hightop/mongoid"
  Mongoid::Document::ClassMethods.include(Hightop::Mongoid)
end
