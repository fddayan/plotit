require 'active_support/all'

require 'plotit/version'
require 'plotit/parse_date'
require 'plotit/guff_ploter'
require 'plotit/stdin_collector'
require 'plotit/groupped'
require 'plotit/groupped/layouts/base'
require 'plotit/groupped/layouts/date_string'
require 'plotit/groupped/layouts/date_number'
require 'plotit/groupped/layouts/string'
require 'plotit/charts/layouts/date_numbers'
require 'plotit/charts/layouts/string_number'
require 'plotit/chart'
require 'plotit/cli'


# require 'byebug'

# Bundler.require

require "awesome_print"


module Plotit
  # Your code goes here...
end

class String
  def is_number?
    true if Float(self) rescue false
  end
end
