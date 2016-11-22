module Plotit
  module Charts
    module Layouts
      class StringNumber

        attr_reader :chart_size, :data, :delimiter, :rows

        def initialize(options)
          @chart_size = '1600x800'
          @data = {}
          @rows = 0
          @delimiter = options[:delimiter]
          @output_path = options[:output_path]
        end

        def add_line(line)
          @rows += 1
          columns = line.strip.chomp.split(delimiter)

          key = columns.shift
          data[key] = columns.shift.to_i
        end

        def gruff_instance
          Gruff::Bar.new(chart_size).tap do |g|
            # g.bar_spacing = 0.5
            g.marker_font_size = 10
            g.legend_font_size = 10
            data.each do |legend, values|
              g.data(legend, values)
            end
          end
        end

        def plot_to(output_path)
          gruff_instance.write(@output_path)
        end
      end
    end
  end
end
