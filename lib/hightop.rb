# dependencies
require "active_support"

# modules
require "hightop/enumerable"
require "hightop/version"

ActiveSupport.on_load(:active_record) do
  require "hightop/utils"
  require "hightop/kicks"
  extend Hightop::Kicks
end

ActiveSupport.on_load(:mongoid) do
  require "hightop/mongoid"
  Mongoid::Document::ClassMethods.include(Hightop::Mongoid)
end
