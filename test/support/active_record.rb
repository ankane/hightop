require "active_record"

# for debugging
ActiveRecord::Base.logger = $logger

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :visits do |t|
  t.string :city
  t.string :user_id
end

class Visit < ActiveRecord::Base
end
