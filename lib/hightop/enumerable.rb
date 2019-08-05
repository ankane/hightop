module Enumerable
  def top(*args, &block)
    if block || !respond_to?(:scoping)
      limit, options, _ = args
      if limit.is_a?(Hash) && args.size == 1
        options = limit
        limit = nil
      end
      options ||= {}
      min = options[:min]

      counts = Hash.new(0)
      map(&block).each do |v|
        counts[v] += 1
      end
      counts.delete(nil) unless options[:nil]
      counts.select! { |_, v| v >= min } if min

      arr = counts.sort_by { |_, v| -v }
      arr = arr[0...limit] if limit
      Hash[arr]
    else
      scoping { @klass.send(:top, *args, &block) }
    end
  end
end
