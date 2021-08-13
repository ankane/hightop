module Hightop
  module Kicks
    def top(column, limit = nil, distinct: nil, min: nil, nil: nil)
      columns = column.is_a?(Array) ? column : [column]
      columns = columns.map { |c| Utils.validate_column(c) }

      distinct = Utils.validate_column(distinct) if distinct

      relation = group(*columns).order("1 DESC", *columns)
      if limit
        relation = relation.limit(limit)
      end

      # terribly named option
      unless binding.local_variable_get(:nil)
        columns.each do |c|
          c = Utils.resolve_column(self, c)
          relation = relation.where("#{c} IS NOT NULL")
        end
      end

      if min
        if distinct
          d = Utils.resolve_column(self, distinct)
          relation = relation.having("COUNT(DISTINCT #{d}) >= #{min.to_i}")
        else
          relation = relation.having("COUNT(*) >= #{min.to_i}")
        end
      end

      if distinct
        relation.distinct.count(distinct)
      else
        relation.count
      end
    end
  end
end
