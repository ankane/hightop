require "hightop/version"
require "active_record"

module Hightop

  def top(column, limit = nil, options = {})
    if limit.is_a?(Hash)
      options = limit
      limit = nil
    end

    unless column.is_a? Array
      column = [column]
    end

    # put table name in front of attributes,
    # this prevents AR mangling of column names
    # where event_id sometimes became event_id_id
    column = column.map { |col|
      "#{table_name}.#{col}"
    }

    order_str = column.join(", ")

    relation = group(column).order("count_#{options[:uniq] || "all"} DESC, #{order_str}")
    if limit
      relation = relation.limit(limit)
    end

    unless options[:nil]
      (column.is_a?(Array) ? column : [column]).each do |c|
        relation = relation.where("#{c} IS NOT NULL")
      end
    end

    if options[:min]
      relation = relation.having("COUNT(*) >= #{options[:min].to_i}")
    end

    if options[:uniq]
      relation.uniq.count(options[:uniq])
    else
      relation.count
    end
  end

end

ActiveRecord::Base.send :extend, Hightop
