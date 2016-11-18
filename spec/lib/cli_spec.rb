require 'spec_helper'

describe Plotit::Cli do

  let(:output_folder) { './tmp/output' }

  describe 'with date in first column' do
    it 'should create timeline chart ' do
      run_type! :timeline
    end

    it 'with many more column should create timeline' do
      run_type! :timeline_multi_lines
    end
  end

  describe 'with string in first column' do
    it 'with one more column should create barcart' do
      run_type! :bar
    end

    it 'with many more column should create barcart' do
      run_type! :bar_multi_lines
    end
  end

  ####################################
  #           HELPERS
  ####################################

  def run_type!(type)
    run! "./spec/fixtures/#{type}.txt", "#{output_folder}/#{type}.png"
  end

  def run!(file, output_file)
    lines = File.read(file)
    Plotit::Cli.new(filename: output_file).run(lines)

    `open #{output_file}`
  end
end


