require 'spec_helper'

describe Plotit::Cli do

  let(:output_folder) { './tmp/output' }

  describe '#plotit' do
    describe 'with date in first column' do
      it 'should create timeline chart ' do
        run_plotit_type! :timeline
      end

      it 'with many more column should create timeline' do
        run_plotit_type! :timeline_multi_lines
      end
    end

    describe 'with string in first column' do
      it 'with one more column should create barcart' do
        run_plotit_type! :bar
      end

      it 'with many more column should create barcart' do
        run_plotit_type! :bar_multi_lines
      end
    end
  end


  describe "#groupped" do

    context 'with date ' do
      it 'should count' do
        run_groupped! :date_ips, :count
      end

      it 'should calc average' do
        run_groupped! :date_counts, :avg
      end

      it 'should sum' do
        run_groupped! :date_counts, :sum
      end
    end

    context 'with name ' do
      it 'should count' do
        run_groupped! :name_ips, :count
      end

      it 'should calc average' do
        run_groupped! :name_counts, :avg
      end

      it 'should sum' do
        run_groupped! :name_counts, :sum
      end
    end
  end

  ####################################
  #           HELPERS
  ####################################

  def run_groupped!(file, formula)
    file = "./spec/fixtures/#{file}.txt"
    lines = File.read(file)
    Plotit::Cli.new(filename: '').groupped(lines, STDOUT, formula)
  end

  def run_plotit_type!(type)
    run_plotit! "./spec/fixtures/#{type}.txt", "#{output_folder}/#{type}.png"
  end

  def run_plotit!(file, output_file)
    lines = File.read(file)
    Plotit::Cli.new(filename: output_file).plotit(lines)

    `open #{output_file}`
  end
end


