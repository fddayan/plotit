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

      collector = Plotit::Chart.new({
        output_path: output_path,
        headers: options[:headers]
        })

      collector.set_chart(options[:chart_type])

      input.each_line do |line|
        collector.add_line line
      end

      collector.plot

      `open #{output_path}`
    end


    def groupped(lines, out, options)
      formula = options[:formula] || :count
      truncate_date = options[:truncate]
      layout = options[:layout]
      sort_by = options[:sort]
      is_table = options[:output_format] == 'table'

      g = Plotit::Groupped.new(formula: formula.to_sym, truncate_date: truncate_date)

      g.set_layout(layout)

      first_line = true
      lines.each_line do |line|
        g.add_line line
        first_line = false
      end

      g.completed

      if is_table
        table = Terminal::Table.new do |t|
          g.row_result(sort_by: sort_by, sort_dir: options[:sort_dir]).each do |columns|
            t << columns
          end
        end
        out.write "#{table}"
      else
        g.row_result(sort_by: sort_by, sort_dir: options[:sort_dir]).each do |columns|
          # puts "#{columns}"
          out.write "#{columns.join("\t")}\n" #{}"#{row}\t#{g.fixed_values(value).join("\t")}\n"
        end
      end
    end


  end
end
