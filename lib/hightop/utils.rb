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
            raise ActiveRecord::UnknownAttributeReference, "Query method called with non-attribute argument(s): #{column.inspect}. Use Arel.sql() for known-safe values."
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
