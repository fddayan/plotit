# ParseDate
#
# A helper for parsing dates of an unknown format.
#
# Takes a randomly formatted date and makes a best guess at the date, or throws and exception if
# there's no best guess.  Will take international dates into account if you pass in a 'short form' date
# to help suggest a starting point for the search.
# Will also try Chronic parsing to get relative dates (yesterday, tomorrow, in 3 days, etc.)
#
# Examples:
#   date = ParseDate.parse('08-09-1977')
#   date = ParseDate.parse('09-08-1977', :short_form => '%d/%m/%y')
#   date = ParseDate.parse('August 09, 1977')
#   date = ParseDate.parse('yesterday')
#
# ParseDate is free and open... you can redistribute it and/or modify
# it anyway you see fit.  No warrantee or guarantee provided :)

require 'date'
require 'chronic'

module Plotit
  module ParseDate

    DATE_FORMAT = '%Y-%m-%d %H:%M:%S'

    def self.short_format(date)
      date.strftime('%d/%m/%y %H:%M:%S')
    end

    def self.date?(date_string)
      parse(date_string) && true rescue false
    end

    def self.truncate(date, to = :hour)
      if to.nil?
        date.strftime(DATE_FORMAT)
      else
        date.change(to.to_sym => 0).strftime(DATE_FORMAT)
      end
       # "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}"
    end

    # Parse a date of unknown format.
    # Optionally, you can pass in a "short_form" to suggest potential characteristics expected.
    # It will be used to determine if the date is international format, or US formatted
    # (Note: Date separators don't matter with short dates, they will be stripped out)
    def self.parse( date_string, options={} )
      # date = nil
      # short_form = options[:short_form]

      # if(day_before_month?(short_form))
      #   # Normalize separators
      #   shorted_date_string = date_string.gsub(/[\.-]/,"/")
      #   shorted_short_form = short_form.gsub(/[\.-]/,"/")

      #   if(long_year?(date_string))
      #     date ||= Date.strptime(shorted_date_string, shorted_short_form.gsub(/\%y/,"\%Y")) rescue nil
      #   else
      #     date ||= Date.strptime(shorted_date_string, shorted_short_form.gsub(/\%Y/, "\%y")) rescue nil
      #   end
      # end
      # date ||= Chronic.parse(date_string).to_datetime rescue nil
      # date ||= DateTime.parse(date_string) # allow this exception through if we can't parse at all
      # date
      DateTime.parse(date_string)
    end

    # private

    # # determine if this is an international date format (day before month before year)
    # def self.day_before_month?(short_form)
    #   return false if short_form.nil?
    #   (/\%d/i =~ short_form) < (/\%m/i =~ short_form)
    # end

    # # Figure out if we have a long (4 digit) year
    # def self.long_year?(date)
    #   # if no spaces...
    #   if(date.strip.index(' ').nil?)
    #     # split on -, /, or . (valid separators for dates I guess.)
    #     parts = date.split(/[-\/\.]/)
    #     # if the first bit, or last bit if 4 chars
    #     (parts.first.size == 4) || (parts.last.size == 4)
    #   end
    # end

  end
end
