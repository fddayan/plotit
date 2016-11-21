module Plotit
  class Chart

    def initialize(options = {})
      @options = options
    end

    def set_chart(chart_type)
      @chart = case chart_type.to_sym
      when :timeline then Plotit::Charts::Layouts::DateNumbers.new(@options)
      end
    end

    def add_line(line)
      @chart.add_line(line)
    end

    def plot
      @chart.plot
    end
  end
end
