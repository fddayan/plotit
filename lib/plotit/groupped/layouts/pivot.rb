require 'set'

module Plotit
  class Groupped
    module Layouts
      module Pivot

        def build_keys(columns)
        end

        def inc_row(key1, key2)
          @rows[key1] ||= {}
          @rows[key1][key2] ||= 0
          @rows[key1][key2] += 1
          headers << key2
        end

        def add_row(columns)
          inc_row *build_keys(columns)
        end

        def headers
          @headers ||= Set.new
        end

        def fixed_values(values)
          headers.map { |h| values[h] || 0 }
        end

        def row_result
          [].tap do |arr|
            arr << [['legend'] + headers.to_a]
            rows.map do |row, value|
              arr << [[row] + fixed_values(value)]
            end
          end
        end

        def completed

        end


      end
    end
  end
end