module Hightop
  module Utils
    class << self
      # basic version of Active Record disallow_raw_sql!
      # symbol = column (safe), Arel node = SQL (safe), other = untrusted
      # matches table.column and column
      def validate_column(column)
        unless column.is_a?(Symbol) || column.is_a?(Arel::Nodes::SqlLiteral)
          column = column.to_s
          unless /\A\w+(\.\w+)?\z/i.match(column)
            warn "[hightop] Non-attribute argument: #{column}. Use Arel.sql() for known-safe values. This will raise an error in Hightop 0.3.0"
          end
        end
        column
      end

      # resolves eagerly
      def resolve_column(relation, column)
        node = relation.send(:relation).send(:arel_columns, [column]).first
        node = Arel::Nodes::SqlLiteral.new(node) if node.is_a?(String)
        relation.connection.visitor.accept(node, Arel::Collectors::SQLString.new).value
      end
    end
  end
end
