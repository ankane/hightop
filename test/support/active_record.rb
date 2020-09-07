require "active_record"

# for debugging
ActiveRecord::Base.logger = $logger

# migrations
case ENV["ADAPTER"]
when "postgresql"
  ActiveRecord::Base.establish_connection adapter: "postgresql", database: "hightop_test"
when "mysql"
  ActiveRecord::Base.establish_connection adapter: "mysql2", database: "hightop_test"
else
  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
end

ActiveRecord::Migration.create_table :visits, force: true do |t|
  t.string :city
  t.string :user_id
end

class Visit < ActiveRecord::Base
end
