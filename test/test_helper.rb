require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "logger"
require "active_record"

Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)

# for debugging
ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT) if ENV["VERBOSE"]

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :visits do |t|
  t.string :city
  t.string :user_id
end

class Visit < ActiveRecord::Base
end
