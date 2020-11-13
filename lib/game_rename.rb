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

# Text-based sidecar file, describing image contents
class SideCarFile
  attr_reader :contents

  def initialize(path)
    @path = path
    @contents = ''
  end

  def read_contents
    @contents = File.read(@path).split
    # file = File.open(@path)
    # @contents = file.readlines.map(&:chomp)
    # file.close
  end

  def line_by_line
    File.foreach(@path) { |line| puts line }
  end
end

# The directory in which the source files are contained
class GameDir
  attr_reader :image_filepaths, :sidecar_filepaths

  def initialize(path)
    @path = path
    @image_filepaths = find_filepaths_by_extension('bin', 'img', 'sub', 'mdf', 'iso')
    @sidecar_filepaths = find_filepaths_by_extension('gdi', 'cdi', 'ccd', 'mds')
    @sidecar_files = {}
  end

  def find_filepaths_by_extension(*args)
    filepaths = {}
    args.each { |arg| filepaths[arg] = get_files_by_type(arg) }
    filepaths
  end

  def get_files_by_type(extension)
    Dir.glob("#{@path}/*.#{extension}", File::FNM_CASEFOLD)
  end

# This will only store the last file of each type - make each hash item an array
#   def load_sidecar_files
#     @sidecar_filepaths.each do |extension, paths|
#       if path != ''
#         puts 'Is run'
#         @sidecar_files[extension] = SideCarFile.new(path)
#         @sidecar_files[extension].line_by_line
#       end
#     end
#   end
end

options = parse_command

p options[:input_dir]

if options[:input_dir]
  game_dir = GameDir.new(options[:input_dir])
  puts game_dir.image_filepaths
  puts game_dir.sidecar_filepaths
end

# Sense checks
#   That GDIs are not really CDIs
#   Files referred to in sidecars are present
#   Unsupported files are not used
#   Whether there are other files or directories
#   Proper filetype check?
#   Sidecar filenames match real filenames
#   More than one of same sidecar type
