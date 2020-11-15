# frozen_string_literal: false

require_relative 'game_track'

# Text-based sidecar file, describing image contents
class SideCarFile
  attr_reader :contents

  def initialize(path)
    @path = path
    @contents = []
    @tracks = []
    populate_contents
    print_contents
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

# A GDI Sidecar File
class GdiSideCarFile < SideCarFile
  def initialize(path)
    super(path)
    populate_tracks
  end

  def populate_tracks
    @contents.drop(1).each { |track| @tracks.append(GdiTrack.new(track)) }
  end

  def display_tracks
    @populate_tracks
  end
end
