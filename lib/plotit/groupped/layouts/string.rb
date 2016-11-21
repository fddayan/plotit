require 'set'

module Plotit
  class Groupped
    module Layouts
      class String

        def initialize(options)
          @rows = {}
        end

        def add_row(columns)
          key = columns.first

          @rows[key] ||= 0
          @rows[key] += 1
        end

        def completed
        end

        def row_result
          @rows
        end
      end
    end
  end
end
