require "hightop/version"

module Hightop

  def top(column, limit = nil)
    column = connection.quote_table_name(column)
    group(column).where("#{column} IS NOT NULL").order("count_all DESC, #{column}").limit(limit).count
  end

end

ActiveRecord::Base.send :extend, Hightop
