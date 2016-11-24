require 'set'

module Plotit
  class Groupped
    module Layouts
      module Pivot

        def build_keys(columns)
          raise "should be implemented"
        end

        def inc_row(key1, key2, value = 1)
          @rows[key1] ||= {}
          @rows[key1][key2] ||= 0
          @rows[key1][key2] += value.to_f
          headers << key2
        end

        def add_row(columns)
          inc_row *build_keys(columns), value_column(columns)
        end

        def value_column(columns)
          columns[2] || 1
        end

        def headers
          @headers ||= Set.new
        end

        def fixed_values(values)
          headers.map { |h| values[h] || 0 }
        end

        def row_result(options = {})
          [].tap do |arr|
            arr << (['legend'] + headers.to_a)
            rows.map do |row, value|
              arr << [row] + fixed_values(value)
            end
          end
        end

        def completed

        end

      end
    end
  end
end
