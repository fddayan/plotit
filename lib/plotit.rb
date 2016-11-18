require 'active_support/all'

require 'plotit/version'
require 'plotit/parse_date'
require 'plotit/guff_ploter'
require 'plotit/stdin_collector'
require 'plotit/cli'

require 'byebug'


module Plotit
  # Your code goes here...
end

class String
  def is_number?
    true if Float(self) rescue false
  end
end
