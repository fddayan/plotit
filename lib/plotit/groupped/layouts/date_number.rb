# 2016-11-18 20:48:26 -0300 34
# 2016-11-18 20:48:27 -0300 48
# 2016-11-18 20:48:28 -0300 11
# 2016-11-18 20:48:29 -0300 36

module Plotit
  class Groupped
    module Layouts
      class DateNumber < Plotit::Groupped::Layouts::Base
        include Plotit::Groupped::Layouts::Formula
        include Plotit::Groupped::Layouts::DateUtils

        def initialize(options)
          super(options)
          @truncate = options[:truncate]
          @rows_count_by_group = {}
        end

        def build_keys(columns)
          [build_date_key(columns.first), columns.second]
        end

      end
    end
  end
end
