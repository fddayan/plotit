module Plotit
  class Chart

    def initialize(options = {})
      @options = options
    end

    def set_chart(chart_type)
      @chart = case chart_type.to_sym
      when :timeline then Plotit::Charts::Layouts::DateNumbers.new(@options)
      when :bar then Plotit::Charts::Layouts::StringNumber.new(@options)
      else
        raise "chart type #{chart_type} unknown"
      end
    end

    def add_line(line)
      @chart.add_line(line)
    end

    def plot
      @chart.plot_to(@options[:output_path])
    end
  end
end
