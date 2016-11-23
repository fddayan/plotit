module Plotit
  class Groupped
    module Layouts
      class Base

        attr_reader :rows, :formula

        def initialize(options)
          @rows = {}
          @formula = options[:formula].to_sym
        end

        def row_result
          rows
        end

      end
    end
  end
end
