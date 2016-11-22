module Plotit
  module Charts
    module Layouts
      class Base

        attr_reader :data, :rows, :delimiter, :output_path
        def initialize(options)
          @chart_size = '1600x800'
          @rows = 0
          @delimiter = options[:delimiter]
          @output_path = options[:output_path]
          @options = options

          @data = {}
        end


        def guff
          gruff_instance.tap do |g|
            g.marker_font_size = 10
            # g.label_max_size = 9
            g.legend_font_size = 10
          end
        end

        def plot_to(output_path)
          gruff_instance.write(output_path)
        end
      end
    end
  end
end
