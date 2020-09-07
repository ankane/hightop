module Hightop
  module Kicks
    def top(column, limit = nil, distinct: nil, uniq: nil, min: nil, nil: nil)
      columns = column.is_a?(Array) ? column : [column]
      columns = columns.map { |c| Utils.resolve_column(self, c) }

      distinct ||= uniq
      distinct = Utils.resolve_column(self, distinct) if distinct

      relation = group(columns).order(["1 DESC"] + columns)
      if limit
        relation = relation.limit(limit)
      end

      # terribly named option
      unless binding.local_variable_get(:nil)
        columns.each do |c|
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
