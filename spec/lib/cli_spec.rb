require 'spec_helper'

describe Plotit::Cli do

  let(:output_folder) { './tmp/output' }

  describe '#plotit' do
    describe 'with date in first column' do
      # it 'should create timeline chart ' do
      #   run_plotit_type! :timeline, :timeline
      # end

      it 'with many more column should create timeline' do
        run_plotit_type! :date_numbers_with_headers, :timeline, { headers: true }
      end
    end

    describe 'with string in first column' do
      it 'with one more column should create barcart' do
        run_plotit_type! :bar, :bar
      end

      it 'with many more column should create barcart' do
        run_plotit_type! :bar_multi_lines, :bar
      end
    end
  end

  describe "#groupped" do

    context 'with date ' do
      it 'should count' do
        run_groupped! :date_string, :date_string, :count
      end

      it 'should calc average' do
        run_groupped! :date_number, :date_number, :avg
      end

      it 'should sum' do
        run_groupped! :date_number, :date_number, :sum
      end
    end

    context 'with name ' do
      pending 'should count' do
        run_groupped! :name_ips, :string_string, :count
      end

      pending 'should calc average' do
        run_groupped! :name_counts, :string_number, :avg
      end

      pending 'should sum' do
        run_groupped! :name_counts, :string_number, :sum
      end
    end
  end

  ####################################
  #           HELPERS
  ####################################

  def run_groupped!(file, layout, formula)
    file = "./spec/fixtures/groupped/#{file}.txt"
    lines = File.read(file)
    Plotit::Cli.new(filename: '').groupped(lines, STDOUT, layout, formula, :min)
  end

  def run_plotit_type!(type, chart_type, options = {})
    run_plotit! "./spec/fixtures/chart/#{type}.txt", "#{output_folder}/#{type}.png", chart_type, options
  end

  def run_plotit!(file, output_file, chart_type, options = {})
    lines = File.read(file)
    Plotit::Cli.new().plotit(lines, options.merge({ chart_type:chart_type,  filename: output_file }))

    `open #{output_file}`
  end
end


