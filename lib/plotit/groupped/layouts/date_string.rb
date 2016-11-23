 # 2016-11-11 19:47:43 +0000   184.75.214.42
 # 2016-11-11 19:53:19 +0000   184.75.214.42
 # 2016-11-11 19:53:19 +0000   184.75.214.42
 # 2016-11-11 19:53:20 +0000   184.75.214.42

module Plotit
  class Groupped
    module Layouts
      class DateString < Plotit::Groupped::Layouts::Base
        include Plotit::Groupped::Layouts::Pivot
        include Plotit::Groupped::Layouts::DateUtils

        def initialize(options)
          super(options)
          @truncate = options[:truncate]
        end

        def build_keys(columns)
          [build_date_key(columns.first), columns.second]
        end

      end
    end
  end
end
