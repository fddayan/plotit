module Plotit
  class Groupped
    module Layouts
      module DateUtils

        def build_date_key(date_string)
          Plotit::ParseDate.truncate(Plotit::ParseDate.parse(date_string), @truncate)
        end
      end
    end
  end
end
