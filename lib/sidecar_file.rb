# frozen_string_literal: false

require_relative 'game_track'

# Text-based sidecar file, describing image contents
class SideCarFile
  attr_reader :contents

  def initialize(path)
    @path = path
    @init_contents = []
    @new_contents = []
    @tracks = []
    populate_contents
  end

  def populate_contents
    @init_contents = File.read(@path).split
    file = File.open(@path)
    @init_contents = file.readlines.map(&:chomp)
    file.close
  end

  def orininal_file_names
    []
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

  # def original_file_names
  #   original_names = []
  #   @tracks.each { |track| original_names.append(track.original_track_name) }
  #   original_names = []
  # end

  def populate_tracks
    @init_contents.drop(1).each { |track| @tracks.append(GdiTrack.new(track)) }
  end

  def rename_tracks
    @tracks.each { |track| track.rename_track('track', 'bin') }
  end

  def write_tracks
    @new_contents.append(@init_contents[0])
    @tracks.each { |track| @new_contents.append(track.new_track_string) }
    # pp @new_contents
  end
end

def provide_sidecar(extension, filepath)
  case extension.downcase
  when 'gdi'
    sidecar = GdiSideCarFile.new(filepath)
  when 'cue'
    sidecar = SideCarFile.new(filepath)
  end
  sidecar
end
