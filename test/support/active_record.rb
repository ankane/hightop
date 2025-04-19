require "active_record"

# for debugging
ActiveRecord::Base.logger = $logger
ActiveRecord::Migration.verbose = ENV["VERBOSE"]

# migrations
case ENV["ADAPTER"]
when "postgresql"
  ActiveRecord::Base.establish_connection adapter: "postgresql", database: "hightop_test"
when "mysql"
  ActiveRecord::Base.establish_connection adapter: "mysql2", database: "hightop_test"
when "trilogy"
  ActiveRecord::Base.establish_connection adapter: "trilogy", database: "hightop_test", host: "127.0.0.1"
else
  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
end

ActiveRecord::Schema.define do
  create_table :visits, force: true do |t|
    t.string :city
    t.string :user_id
  end
end

class Visit < ActiveRecord::Base
end
