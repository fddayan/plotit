require 'plotit/groupped/layouts/base'
require 'plotit/groupped/layouts/pivot'
require 'plotit/groupped/layouts/formula'
require 'plotit/groupped/layouts/date_utils'

%w(date_string date_number string_number string string_string).each do |layout|
  require "plotit/groupped/layouts/#{layout}"
end

module Plotit
  class Groupped

    LAYOUTS = {
      date_string: Plotit::Groupped::Layouts::DateString,
      string: Plotit::Groupped::Layouts::String,
      string_number: Plotit::Groupped::Layouts::StringNumber
    }

    attr_reader :formula, :truncate_date

    def initialize(options = {})
      @formula = options[:formula]
      @truncate_date = options[:truncate_date]
    end

    def set_layout(layout)
      @layout = case layout.to_sym
      when :date_string
        Plotit::Groupped::Layouts::DateString.new(formula: @formula, truncate: @truncate_date)
      when :string
        Plotit::Groupped::Layouts::String.new(formula: @formula, truncate: @truncate_date)
      when :date_number
        Plotit::Groupped::Layouts::DateNumber.new(formula: @formula, truncate: @truncate_date)
      when :string_number
        Plotit::Groupped::Layouts::StringNumber.new(formula: @formula, truncate: @truncate_date)
      when :string_string
        Plotit::Groupped::Layouts::StringString.new(formula: @formula, truncate: @truncate_date)
      else
        raise "layout #{layout} not found"
      end

      # if LAYOUTS.key?(layout.to_sym)
      #   LAYOUTS[layout.to_sym].new(formula: @formula, truncate: @truncate_date)
      # else
      #   raise "layout #{layout} not found"
      # end
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

    def row_result(options = {})
      @layout.row_result(options).to_a.tap do |arr|
        if options[:sort_by].present?
          column_idx = options[:sort_by].abs - 1
          if options[:sort_dir] == 'desc'
            arr.sort! { |a, b| b[column_idx] <=> a[column_idx] }
          else
            arr.sort! { |a, b| a[column_idx] <=> b[column_idx] }
          end
        end
      end
    end

    # def headers
    #   @layout.headers
    # end

    def completed
      @layout.completed
    end

  end
end
