
module Plotit
  module Charts
    module Layouts
      class DateNumbers
        TIMELINE_MAX_LABELS = 4

        attr_reader :data, :headers

        def initialize(options)
          @data = []
          @options = options
          @chart_size = '1600x800'
          @output_path = options[:output_path]
          @options[:delimiter] ||= "\t"
          @has_header = options[:headers]
          @rows = 0
          @options = options
        end

        def delimiter
          @options[:delimiter]
        end

        def add_line(line)
          @rows += 1
          columns = line.strip.chomp.split(delimiter)
          if @rows == 1
            if @has_header
              columns.shift #remove first
              @headers = columns
            else
              @headers = (columns.size - 1).times.map { |n| "Legend#{n}" }
            end
          else
            x_key = Plotit::ParseDate.parse(columns.shift)
            # add_columns x_key, columns

            @data << {date: x_key}.merge(headers_value_hash(@headers, columns))
          end
        end

        def headers_value_hash(headers, columns)
          Hash[headers.each_with_index.map { |h, idx| [h, columns[idx]] }]
        end

        def add(x_key, columns)
          columns.each_with_index.each do |value, index|
            increment_value x_key, index, value
          end
        end

        def increment_value(x_key, index, value)
          legend = @has_header ? @headers[index] : "legend#{index}"

          @data[legend] ||= {}
          @data[legend][x_key] ||= 0
          @data[legend][x_key] = value.is_number? ? value.to_i : 1
        end

        def gruff_instance
          Gruff::Line.new(@chart_size).tap do |g|
            g.hide_dots = true
            g.line_width = 1
            g.labels = labels
            data_by_legend.each do |legend, values|
              g.data(legend, values)
            end
          end
        end

        def data_by_legend
          {}.tap do |h|
            data.map do |date_row|
              date_row.except(:date).each do |legend, value|
                h[legend] ||= []
                h[legend] << value.to_i
              end
            end
          end
        end

        def xlables
          @xlables ||= data.map { |e| Plotit::ParseDate.short_format(e[:date]) }
        end

        def to_labels_hash(labels_arr, multiplier = 1)
          Hash[labels_arr.each_with_index.map { |key, index| [index * multiplier, key] }]
        end

        def labels
          a = xlables.size / TIMELINE_MAX_LABELS
          if a > 1
            l = (1...xlables.size).step(a).take(TIMELINE_MAX_LABELS).map { |i| xlables[i] }
            to_labels_hash l, 10
          else
            to_labels_hash xlables
          end
        end

        def guff
          gruff_instance.tap do |g|
            g.marker_font_size = 10
            # g.label_max_size = 9
            g.legend_font_size = 10
          end
        end

        def plot_to(output_path)
          # puts @data
          guff.write(output_path)
        end
      end
    end
  end
end
