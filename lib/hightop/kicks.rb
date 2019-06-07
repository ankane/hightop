module Hightop
  module Kicks
    def top(column, limit = nil, distinct: nil, uniq: nil, min: nil, nil: nil)
      distinct ||= uniq
      order_str = column.is_a?(Array) ? column.map(&:to_s).join(", ") : column
      relation = group(column).order(["count_#{distinct || 'all'} DESC", order_str])
      if limit
        relation = relation.limit(limit)
      end

      # terribly named option
      unless binding.local_variable_get(:nil)
        (column.is_a?(Array) ? column : [column]).each do |c|
          relation = relation.where("#{c} IS NOT NULL")
        end
      end

      if min
        relation = relation.having("COUNT(#{distinct ? "DISTINCT #{distinct}" : '*'}) >= #{min.to_i}")
      end

      if distinct
        # since relation.respond_to?(:distinct) can't be used
        if ActiveRecord::VERSION::MAJOR > 3
          relation.distinct.count(distinct)
        else
          relation.uniq.count(distinct)
        end
      else
        relation.count
      end
    end
  end
end
