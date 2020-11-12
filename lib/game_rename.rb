#!/home/jimnarey/.rbenv/shims/ruby
# frozen_string_literal: false

require 'optparse'

# This will hold the options we parse
options = {}

OptionParser.new do |parser|
  parser.banner = 'Usage: hello.rb [options]'
  parser.on('-h', '--help', 'Show this help message') do
    puts parser
  end

  # Whenever we see -n or --name, with an
  # argument, save the argument.
  parser.on('-i', '--input INPUTDIR', "The directory containing a single game's GDI and track files.") do |v|
    options[:name] = v
  end
end.parse!

# Now we can use the options hash however we like.
puts "Hello #{options[:name]}" if options[:name]
