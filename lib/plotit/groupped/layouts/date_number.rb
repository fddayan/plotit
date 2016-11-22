# 2016-11-18 20:48:26 -0300 34
# 2016-11-18 20:48:27 -0300 48
# 2016-11-18 20:48:28 -0300 11
# 2016-11-18 20:48:29 -0300 36

module Plotit
  class Groupped
    module Layouts
      class DateNumber < Plotit::Groupped::Layouts::Base

        def initialize(options)
          super(options)
          @truncate = options[:truncate]
          @rows_count_by_group = {}
        end

        def add_row(columns)
          date_string = columns[0]
          number = columns[1]

          date_truncated = Plotit::ParseDate.truncate(Plotit::ParseDate.parse(date_string), @truncate)

          rows[date_truncated] = run_forumla(formula, rows, date_truncated, number)

          @rows_count_by_group[date_truncated] ||= 0
          @rows_count_by_group[date_truncated] += 1
        end

        def completed
          if formula == :avg
            rows.each do |key, value|
              rows[key] = value / @rows_count_by_group[key]
            end
          end
        end

        def run_forumla(formula, rows, key, new_value)
          current_value = rows[key] || 0
          case formula
          when :count
            current_value + 1 if columns.size == 1 || columns.second.present?
          when :sum
            current_value + new_value.to_f if new_value.present?
          when :avg
            current_value + new_value.to_f if new_value.present?
          else
            new_value.to_i
          end
        end

        def row_result
          rows
        end

      end
    end
  end
end
