module Plotit
  class Cli

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def output_path
      "#{Dir.pwd}/#{options[:filename]}"
    end

    def run(input)
      collector = Plotit::StdinCollector.new
      first_line = true
      input.each_line do |line|
        collector.set_chart_type_from_line(line) if first_line
        collector.add_line line
        first_line = false
      end

      puts "Output to #{output_path}"

      Plotit::GuffPloter.new(collector.data, output_path, collector.data_type).plot
    end
  end
end
