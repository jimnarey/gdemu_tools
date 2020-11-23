# frozen_string_literal: false

# Class to hold each track in a GDI sidecar file
class GdiTrack
  attr_reader :track_name, :track_other

  def initialize(track_string)
    @track_string = track_string
    @track_name_open_quote_index = track_string.index('"')
    @track_name_close_quote_index = track_string.index('"', @track_name_open_quote_index + 1)
    @track_name = track_string[@track_name_open_quote_index + 1..@track_name_close_quote_index - 1]
    @track_other = track_string.gsub(track_name, '')
    @new_track_string = ''
  end

  def rename_track(name)
    @new_track_string = @track_other.insert(@track_name_open_quote_index, name)
  end
end
