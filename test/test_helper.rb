require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "logger"

# for debugging
# ActiveRecord::Base.logger = Logger.new(STDOUT)

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :visits do |t|
  t.string :city
  t.string :user_id
end

class Visit < ActiveRecord::Base
end
