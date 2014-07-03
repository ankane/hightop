require "hightop/version"
require "active_record"

module Hightop

  def top(column, limit = nil, options = {})
    if limit.is_a?(Hash)
      options = limit
      limit = nil
    end

    order_str = column.is_a?(Array) ? column.map(&:to_s).join(", ") : column
    relation = group(column).order("count_all DESC, #{order_str}")
    if limit
      relation = relation.limit(limit)
    end

    unless options[:nil]
      (column.is_a?(Array) ? column : [column]).each do |c|
        relation = relation.where("#{c} IS NOT NULL")
      end
    end

    relation.count
  end

end

ActiveRecord::Base.send :extend, Hightop
