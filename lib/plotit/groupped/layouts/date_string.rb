require 'set'
module Plotit
  class Groupped
    module Layouts
      class DateString

        attr_reader :formula, :rows, :headers

        def initialize(options)
          @rows = {}
          @formula = options[:formula].to_sym
          @truncate = options[:truncate]
          @rows_count_by_group = {}
          @headers = Set.new
        end

        def add_row(columns)
          date_key = Plotit::ParseDate.truncate(Plotit::ParseDate.parse(columns.first), @truncate)
          legend_key = columns.second

          set_row date_key, legend_key, 0

          run_forumla date_key, legend_key, columns
        end

        def set_row(k1, k2, value)
          @headers << k2
          rows[k1] ||= {}
          rows[k1][k2] ||= value
        end

        def run_forumla(k1, k2, columns)
          case formula
          when :count
            rows[k1][k2] += 1 if columns.size == 1 || columns.second.present?
          when :sum
            rows[k1][k2] += columns.second.to_i if columns.second.present?
          when :avg
            rows[k1][k2] += columns.second.to_i if columns.second.present?
          end
        end

        def fixed_values(values)
          @headers.map { |h| values[h] || 0 }
        end

        def completed
          # if formula == :avg
          #   rows.each do |key, value|
          #     rows[key] = value / @rows_count_by_group[key]
          #   end
          # end
        end

        def inc_count(k1, k2)
          @rows_count_by_group[k1] ||= {}
          @rows_count_by_group[k1][k2] ||= 0
          @rows_count_by_group[k1][k2] += 1
        end

      end
    end
  end
end
