module Plotit
  class Cli

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def plotit(input, options)
      raise ":chart_type is required" unless options[:chart_type]

      filename = options[:filename] || 'out.png'
      output_path = "#{Dir.pwd}/#{filename}"


      # collector =  Plotit::Charts::Layouts::DateNumbers.new({
      #   output_path: output_path,
      #   headers: options[:headers]
      #   })

      collector = Plotit::Chart.new({
        output_path: output_path,
        headers: options[:headers]
        })

      collector.set_chart(options[:chart_type])

      input.each_line do |line|
        collector.add_line line
      end

      # puts ">> HEADERS:"
      # puts "#{collector.headers}"

      # puts ">> DATA:"
      # ap collector.data

      collector.plot

      # collector = Plotit::Charts::Layouts::DateNumbers.new(:) #Plotit::StdinCollector.new(options)
      # first_line = true
      # input.each_line do |line|
      #   # collector.set_chart_type_from_line(line) if first_line
      #   collector.add_line line
      #   first_line = false
      # end

      # puts "Output to #{output_path}"

      # Plotit::GuffPloter.new(collector.data, output_path, options[:chart_type] ).plot

      `open #{output_path}`
    end


    def groupped(lines, out, layout, formula, truncate_date)
      g = Plotit::Groupped.new(formula: formula.to_sym, truncate_date: truncate_date)

      g.set_layout(layout)

      first_line = true
      lines.each_line do |line|
        # collector.set_layout_from_line(line) if first_line
        g.add_line line
        first_line = false
      end

      g.completed

      # puts [['date'] + g.headers.to_a].join("\t")
      # g.rows.each do |row, value|
      #   out.write "#{row}\t#{g.fixed_values(value).join("\t")}\n"
      # end

      g.row_result.each do |columns|
        out.write "#{columns.join("\t")}\n" #{}"#{row}\t#{g.fixed_values(value).join("\t")}\n"
      end
    end


  end
end
