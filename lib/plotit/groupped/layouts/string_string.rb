# Name2 t184.75.214.42
# Name0 t184.75.214.42
# Name2 t184.75.214.42

module Plotit
  class Groupped
    module Layouts
      class StringString < Plotit::Groupped::Layouts::Base
        include Plotit::Groupped::Layouts::Pivot

        def build_keys(columns)
          [columns.first, columns.second]
        end

      end
    end
  end
end
