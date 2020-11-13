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

def get_input_files(input_dir)
  files = Dir.entries(input_dir).select { |f| File.file? File.join(input_dir, f) }
  # p files
  files.each do |file|
    puts File.join(input_dir, file)
  end
end

options = {}
parse_command(options)

get_input_files(options[:input_dir]) if options[:input_dir]
