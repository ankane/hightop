module Enumerable
  def top(*args, **options, &block)
    if block || !(respond_to?(:scoping) || respond_to?(:with_scope))
      raise ArgumentError, "wrong number of arguments (given 2, expected 0..1)" if args.size > 1

      limit = args[0]
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
    elsif respond_to?(:scoping)
      scoping { @klass.send(:top, *args, **options, &block) }
    else
      with_scope(self) { klass.send(:top, *args, **options, &block) }
    end
  end
end
