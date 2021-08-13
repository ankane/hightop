module Hightop
  module Mongoid
    # super helpful article
    # https://maximomussini.com/posts/mongoid-aggregation-dsl/
    def top(column, limit = nil, distinct: nil, min: nil, nil: nil)
      columns = column.is_a?(Array) ? column : [column]

      relation = all

      # terribly named option
      unless binding.local_variable_get(:nil)
        columns.each do |c|
          relation = relation.and(c.ne => nil)
        end
      end

      ids = {}
      columns.each_with_index do |c, i|
        ids["c#{i}"] = "$#{c}"
      end

      if distinct
        # group with distinct column first, then group without it
        # https://stackoverflow.com/questions/24761266/select-group-by-count-and-distinct-count-in-same-mongodb-query/24770233#24770233
        distinct_ids = ids.merge("c#{ids.size}" => "$#{distinct}")
        relation = relation.group(_id: distinct_ids, count: {"$sum" => 1})
        ids.each_key do |k|
          ids[k] = "$_id.#{k}"
        end
      end

      relation = relation.group(_id: ids, count: {"$sum" => 1})

      if min
        relation.pipeline.push("$match" => {"count" => {"$gte" => min}})
      end

      relation = relation.desc(:count)
      if limit
        relation = relation.limit(limit)
      end

      result = {}
      collection.aggregate(relation.pipeline).each do |doc|
        key = doc["_id"].values
        key = key[0] if key.size == 1
        result[key] = doc["count"]
      end
      result
    end
  end
end
