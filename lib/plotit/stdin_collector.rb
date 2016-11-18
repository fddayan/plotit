require 'date'

module Plotit
  class StdinCollector
    attr_accessor :data_type
    attr_reader :data

    def initialize(options = {})
      @data = {}
      @options = options
      @options[:delimiter] ||= "\t"
    end

    def set_chart_type_from_line(line)
      columns = line.split(delimiter)

      self.data_type = :timeline if Plotit::ParseDate.date?(columns.first)
    end

    def timeline?
      data_type == :timeline
    end

    def delimiter
      @options[:delimiter]
    end

    def add_line(line)
      columns = line.split(delimiter)
      column1 = columns.shift
      increment first_column(column1), columns
    end

    def first_column(data)
      if timeline?
        date = Plotit::ParseDate.parse(data)
        Plotit::ParseDate.truncate(date)
        # "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}"
      else
        data
      end
    end

    def increment(key, columns)
      columns.each_with_index.each do |value, index|
        increment_value key, index, value
      end
    end

    def increment_value(key, index, value)
      @data["legend#{index}"] ||= {}
      @data["legend#{index}"][key] ||= 0
      @data["legend#{index}"][key] += value.is_number? ? value.to_i : 1
    end
  end
end
