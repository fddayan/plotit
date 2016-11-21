module Plotit
  class Groupped

    attr_reader :formula, :truncate_date

    def initialize(options = {})
      @formula = options[:formula]
      @truncate_date = options[:truncate_date]
    end

    def set_layout(layout)
      @layout = case layout.to_sym
      when :date_string then Plotit::Groupped::Layouts::DateString.new(formula: @formula, truncate: @truncate_date)
      when :string then Plotit::Groupped::Layouts::String.new(formula: @formula, truncate: @truncate_date)
      end
    end

    def rows
      @layout.rows
    end

    def fixed_values(values)
      @layout.fixed_values(values)
    end

    def add_line(line)
      columns = line.strip.chomp.split("\t")

      @layout.add_row(columns)
    end

    def row_result
      @layout.row_result
    end

    # def headers
    #   @layout.headers
    # end

    def completed
      @layout.completed
    end

  end
end
