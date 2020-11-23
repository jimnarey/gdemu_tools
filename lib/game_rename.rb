#!/home/jimnarey/.rbenv/shims/ruby
# frozen_string_literal: false

require 'optparse'
require 'pp'
require_relative 'game_source_dir'

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

options = parse_command

if options[:input_dir]
  game_dir = GameSourceDir.new(options[:input_dir])
  # pp game_dir.sidecar_file_collections
  game_dir.gdi_rename
  # pp game_dir.sidecar_file_collections
end

# Sense checks
#   That GDIs are not really CDIs
#   Files referred to in sidecars are present
#   Unsupported files are not used
#   Whether there are other files or directories
#   Proper filetype check?
#   Sidecar filenames match real filenames
#   More than one of same sidecar type

# CCD/IMG/SUB
# CCD, CloneCD Control File, needs an IMG file, GNU ccd2cue cue sheet, ccd2iso (Linux) to iso, supports mixed mode
# SUB, subchannel file
# MFD/MDS
# MDF, Alcohol 120% image, multi-layer, mixed mode
# MDS, inc layer break and layer breach bit
# CUE/BIN (& GDI/BIN)
# CUE, https://en.wikipedia.org/wiki/Cue_sheet_(computing)
