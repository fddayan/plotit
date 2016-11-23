# Name2 t184.75.214.42
# Name0 t184.75.214.42
# Name2 t184.75.214.42
# Name0 t184.75.214.42
# Name0 t184.75.214.42

module Plotit
  class Groupped
    module Layouts
      class StringNumber < Plotit::Groupped::Layouts::Base
        include Plotit::Groupped::Layouts::Formula

        def initialize(options)
          super(options)
          @truncate = options[:truncate]
          @rows_count_by_group = {}
        end

        def build_keys(columns)
          [columns.first, columns.second]
        end

      end
    end
  end
end
