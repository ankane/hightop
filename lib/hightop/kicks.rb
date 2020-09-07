module Hightop
  module Kicks
    def top(column, limit = nil, distinct: nil, uniq: nil, min: nil, nil: nil)
      # basic version of Active Record disallow_raw_sql!
      # symbol = column (safe), Arel node = SQL (safe), other = untrusted
      # matches table.column and column
      (column.is_a?(Array) ? column : [column]).each do |col|
        unless col.is_a?(Symbol) || col.is_a?(Arel::Nodes::SqlLiteral) || /\A\w+(\.\w+)?\z/i.match(col.to_s)
          warn "[hightop] Non-attribute argument: #{col}. Use Arel.sql() for known-safe values. This will raise an error in Hightop 0.3.0"
        end
      end

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
        relation.distinct.count(distinct)
      else
        relation.count
      end
    end
  end
end
