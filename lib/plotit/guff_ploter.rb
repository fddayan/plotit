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

    def plot
      Plotit::Charts::Layouts::DateNumbers.new(output_path: @output_path).plot
    end

    # def xlables
    #   @xlables ||= data.first.second.keys.sort
    # end

    # def labels
    #   case @data_type
    #   when :timeline
    #     a = xlables.size / TIMELINE_MAX_LABELS
    #     if a > 1
    #       l = (1...xlables.size).step(a).take(TIMELINE_MAX_LABELS).map { |i| xlables[i] }
    #       to_labels_hash l, 10
    #     else
    #       to_labels_hash xlables
    #     end
    #   when :bar
    #     to_labels_hash xlables
    #   when :pie
    #     to_labels_hash data.first.second.keys
    #   end
    # end

    # def to_labels_hash(labels_arr, multiplier = 1)
    #   Hash[labels_arr.each_with_index.map { |key, index| [index * multiplier, key] }]
    # end

    # def chart_size
    #   '1600x800'
    # end

    # def gruff_instance
    #   case @data_type
    #   when :timeline
    #     Gruff::Line.new(chart_size).tap do |g|
    #       g.hide_dots = true
    #       g.line_width = 1
    #       data.each do |legend, keys|
    #         puts "#{legend} => #{keys}"
    #         g.data(legend, keys.values)
    #       end
    #     end
    #   when :bar
    #     Gruff::Bar.new(chart_size).tap do |g|
    #       # g.bar_spacing = 0.5
    #       data.each do |legend, keys|
    #         g.data(legend, keys.values)
    #       end
    #     end
    #   when :pie
    #     Gruff::SideBar.new(chart_size).tap do |g|
    #       # g.labels = labels
    #       g.labels = labels

    #       data.each do |legend, values|
    #         g.data(legend, values.values)
    #       end
    #       # [[:Jimmy, [25, 36, 86, 39]]].each do |key, values|
    #       #   g.data(key, values)
    #       # end

    #       # puts data

    #       # data.each do |_, keys|

    #       #   keys.each do |legend, values|
    #       #     puts "#{legend} #{values}"
    #       #     g.data(legend, [values])
    #       #   end
    #       # end
    #     end

    #     # Gruff::Mini::Pie.new(chart_size).tap do |g|
    #     #   g.legend_position = :right
    #     #   g.legend_font_size = 12
    #     #   data.each do |_, keys|
    #     #     keys.each do |legend, values|
    #     #       puts "#{legend} #{values}"
    #     #       g.data(legend, [values])
    #     #     end
    #     #   end
    #     # end

    #     # Gruff::SideBar.new(chart_size).tap do |g|
    #     #   # g.labels = labels
    #     #   g.labels = {0 => '2003', 2 => '2004', 4 => '2005'}
    #     #   g.data("Grapes", [8])
    #     #   g.data("Apples", [24])
    #     #   g.data("Oranges", [32])
    #     #   g.data("Watermelon", [8])
    #     #   g.data("Peaches", [12])
    #     #   # data.each do |_, keys|

    #     #   #   keys.each do |legend, values|
    #     #   #     puts "#{legend} #{values}"
    #     #   #     g.data(legend, [values])
    #     #   #   end
    #     #   # end
    #     # end
    #   end
    # end

    # def guff
    #   gruff_instance.tap do |g|
    #     g.marker_font_size = 9
    #     g.label_max_size = 5
    #   end
    # end

    # def plot
    #   guff.write(@output_path)
    # end
  end
end
