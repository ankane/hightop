Mongoid.logger = $logger
Mongo::Logger.logger = $logger if defined?(Mongo::Logger)

Mongoid.configure do |config|
  config.connect_to "hightop_test"
end

class Visit
  include Mongoid::Document

  field :city, type: String
  field :user_id, type: String
end
