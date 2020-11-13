# frozen_string_literal: false

# Text-based sidecar file, describing image contents
class SideCarFile
  attr_reader :contents

  def initialize(path)
    @path = path
    @contents = []
    @tracks = []
    populate_contents
    # print_contents
  end

  def populate_contents
    @contents = File.read(@path).split
    file = File.open(@path)
    @contents = file.readlines.map(&:chomp)
    file.close
  end

  def print_contents
    p @path
    p @contents
  end

  def populate_tracks
    @tracks = []
  end
end

# Class to hold each track in a GDI sidecar file
class GdiTrack
  def initialize(track_string)
    @track_string = track_string
    @track_number = 0
    @track_offset = 0
    @numeric_unknown_a = 0
    @numeric_unknown_b = 0
    @track_name = ''
    @numeric_unknown_c = 0
  end
end

# A GDI Sidecar File
class GdiSideCarFile < SideCarFile
  def initialize(path)
    super(path)
    populate_tracks
  end

  def populate_tracks
    @contents.drop(1).each { |track| @tracks.append(track) }
  end
end
