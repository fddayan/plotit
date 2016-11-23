module Plotit
  class Groupped
    module Layouts
      module Formula

        def rows_count_by_group
          @rows_count_by_group ||= {}
        end

        def inc_rows_count_by_group(key)
          @rows_count_by_group[key] ||= 0
          @rows_count_by_group[key] += 1
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

        def add_row(columns)
          key, number = build_keys(columns)
          rows[key] = run_forumla(formula, rows, key, number)

          inc_rows_count_by_group key
        end

        def completed
          if formula == :avg
            rows.each do |key, value|
              rows[key] = value / @rows_count_by_group[key]
            end
          end
        end

      end
    end
  end
end
