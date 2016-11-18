require 'gruff'

module Plotit
  class GuffPloter
    attr_reader :data

    TIMELINE_MAX_LABELS = 4

    def initialize(data, output_path, data_type)
      @data = data
      @output_path = output_path
      @data_type = data_type
    end

    def timeline?
      @data_type == :timeline
    end

    def xlables
      @xlables ||= data.first.second.keys.sort
    end

    def labels
      if timeline?
        a = xlables.size / TIMELINE_MAX_LABELS
        if a > 1
          l = (1...xlables.size).step(a).take(TIMELINE_MAX_LABELS).map { |i| xlables[i] }
          to_labels_hash l, 10
        else
          to_labels_hash xlables
        end
      else
        to_labels_hash xlables
      end
    end

    def to_labels_hash(labels_arr, multiplier = 1)
      Hash[labels_arr.each_with_index.map { |key, index| [index * multiplier, key] }]
    end

    def chart_size
      '800x400'
    end

    def gruff_instance
      if timeline?
        Gruff::Line.new(chart_size).tap do |g|
          g.hide_dots = true
          g.line_width = 1
        end
      else
        Gruff::Bar.new(chart_size).tap do |g|
          # g.bar_spacing = 0.5
        end
      end
    end

    def guff
      gruff_instance.tap do |g|
        g.labels = labels
        g.marker_font_size = 15
        g.label_max_size = 15

        data.each do |legend, keys|
          g.data(legend, keys.values)
        end
      end
    end

    def plot
      guff.write(@output_path)
    end
  end
end
