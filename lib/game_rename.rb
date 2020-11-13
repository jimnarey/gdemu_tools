#!/home/jimnarey/.rbenv/shims/ruby
# frozen_string_literal: false

require 'optparse'

def parse_command(options)
  OptionParser.new do |parser|
    parser.banner = 'Usage: hello.rb [options]'
    parser.on('-h', '--help', 'Show this help message') do
      puts parser
    end

    parser.on('-i', '--input INPUTDIR',
              "The directory containing a single game's GDI and track files.") do |input_dir_arg|
      options[:input_dir] = input_dir_arg
    end
  end.parse!
end

# Now we can use the options hash however we like.
# puts "Input dir is #{options[:input_dir]}" if options[:input_dir]

options = {}
parse_command(options)

if options[:input_dir]
  files = Dir.entries(options[:input_dir]).select { |f| File.file? File.join(options[:input_dir], f) }
  p files
  files.each do |file|
    puts File.join(options[:input_dir], file)
  end
end
