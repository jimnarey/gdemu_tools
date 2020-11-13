#!/home/jimnarey/.rbenv/shims/ruby
# frozen_string_literal: false

require 'optparse'

# Shorten this and renable linter check
def parse_command
  options = {}
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
  options
end

# The directory in which the source files are contained
class GameDir
  attr_reader :image_files

  def initialize(path)
    @path = path
    @image_files = find_image_files
    # puts @game_files
  end

  def find_image_files
    {
      gdi: get_files_by_type('gdi'),
      cdi: get_files_by_type('cdi'),
      bin: get_files_by_type('bin'),
      ccd: get_files_by_type('ccd'),
      img: get_files_by_type('img'),
      sub: get_files_by_type('sub'),
      mds: get_files_by_type('mds'),
      mdf: get_files_by_type('mdf'),
      iso: get_files_by_type('iso')
    }
  end

  def get_files_by_type(extension)
    Dir.glob("#{@path}/*.#{extension}", File::FNM_CASEFOLD)
  end
end

def get_input_files(input_dir)
  Dir.entries(input_dir).select { |f| File.file? File.join(input_dir, f) }
end

def get_file_paths(directory, files)
  file_paths = []
  files.each do |file|
    file_paths.append(File.join(directory, file))
  end
  file_paths
end

def print_array(input_array)
  input_array.each do |item|
    puts item
  end
end

options = parse_command

p options[:input_dir]

if options[:input_dir]
  game_dir = GameDir.new(options[:input_dir])
  puts game_dir.image_files
end
