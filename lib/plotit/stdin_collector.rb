require 'date'

module Plotit
  class StdinCollector
    attr_accessor :data_type
    attr_reader :data

    def initialize(options = {})
      @data = {}
      @options = options
      @options[:delimiter] ||= "\t"
      @has_header = options[:headers]
      @rows = 0
    end

    def set_chart_type_from_line(line)
      columns = line.split(delimiter)

      self.data_type = calc_data_type columns
    end

    def calc_data_type(columns)
      if Plotit::ParseDate.date?(columns.first)
        :timeline
      else # String
        if columns.size == 2
          :pie
        else
          :bar
        end
      end
    end

    def timeline?
      data_type == :timeline
    end

    def delimiter
      @options[:delimiter]
    end

    def add_line(line)
      @rows += 1
      columns = line.strip.chomp.split(delimiter)
      if @has_header && @rows == 1
        @headers = columns
      else
        column1 = columns.shift
        increment first_column(column1), columns
      end
    end

    def first_column(data)
      if timeline?
        # date = Plotit::ParseDate.parse(data)
        # Plotit::ParseDate.truncate(date)
        data
        # "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}"
      else
        data
      end
    end

    def increment(key, columns)
      # puts "#{key} - #{columns}"
      columns.each_with_index.each do |value, index|
        increment_value key, index, value
      end
    end

    def increment_value(key, index, value)
      legend = if @has_header
                  @headers[index]
               else
                  "legend#{index}"
               end

      @data[legend] ||= {}
      @data[legend][key] ||= 0
      @data[legend][key] += value.is_number? ? value.to_i : 1
    end
  end
end
