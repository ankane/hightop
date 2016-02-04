require "hightop/version"
require "active_record"

module Hightop
  def top(column, limit = nil, options = {})
    if limit.is_a?(Hash)
      options = limit
      limit = nil
    end

    distinct = options[:distinct] || options[:uniq]
    order_str = column.is_a?(Array) ? column.map(&:to_s).join(", ") : column
    relation = group(column).order("count_#{distinct || 'all'} DESC, #{order_str}")
    if limit
      relation = relation.limit(limit)
    end

    unless options[:nil]
      (column.is_a?(Array) ? column : [column]).each do |c|
        relation = relation.where("#{c} IS NOT NULL")
      end
    end

    if options[:min]
      relation = relation.having("COUNT(#{distinct ? "DISTINCT #{distinct}" : '*'}) >= #{options[:min].to_i}")
    end

    if options[:distinct]
      relation.distinct.count(options[:distinct])
    elsif options[:uniq]
      relation.uniq.count(options[:uniq])
    else
      relation.count
    end
  end
end

ActiveRecord::Base.send :extend, Hightop
