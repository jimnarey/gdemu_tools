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
    read_contents
    print_contents
  end

  def read_contents
    @contents = File.read(@path).split
    file = File.open(@path)
    @contents = file.readlines.map(&:chomp)
    file.close
  end

  def print_contents
    puts @contents
  end
end

# The directory in which the source files are contained
class GameDir
  attr_reader :image_filepath_collections, :sidecar_filepath_collections

  def initialize(path)
    @path = path
    @image_filepath_collections = find_filepaths_by_extension('bin', 'img', 'sub', 'mdf', 'iso')
    @sidecar_filepath_collections = find_filepaths_by_extension('gdi', 'cue', 'cdi', 'ccd', 'mds')
    @sidecar_file_collections = {}
    load_sidecar_files
  end

  def find_filepaths_by_extension(*args)
    filepaths = {}
    args.each { |arg| filepaths[arg] = get_files_by_type(arg) }
    filepaths
  end

  def get_files_by_type(extension)
    Dir.glob("#{@path}/*.#{extension}", File::FNM_CASEFOLD)
  end

  def load_sidecar_files
    @sidecar_filepath_collections.each do |extension, filepath_collection|
      @sidecar_file_collections[extension] = [] unless @sidecar_file_collections.key?(extension)
      filepath_collection.each do |filepath|
        @sidecar_file_collections[extension].append(SideCarFile.new(filepath))
      end
    end
  end

  def process_gdi_set
    gdi_contents = @sidecar_file_collections['gdi'][0].contents
    puts gdi_contents
  end
end

options = parse_command

p options[:input_dir]

if options[:input_dir]
  game_dir = GameDir.new(options[:input_dir])
  puts game_dir.image_filepath_collections
  puts game_dir.sidecar_filepath_collections
  game_dir.process_gdi_set
end

# Sense checks
#   That GDIs are not really CDIs
#   Files referred to in sidecars are present
#   Unsupported files are not used
#   Whether there are other files or directories
#   Proper filetype check?
#   Sidecar filenames match real filenames
#   More than one of same sidecar type
