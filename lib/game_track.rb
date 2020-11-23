# frozen_string_literal: false

# Class to hold each track in a GDI sidecar file
class GdiTrack
  attr_reader :track_name, :track_other, :new_track_string, :original_track_name

  def initialize(track_string)
    @original_track_string = track_string
    @track_num = track_string.partition(' ').first
    @open_quote_index = track_string.index('"')
    @init_close_quote_index = track_string.index('"', @open_quote_index + 1)
    @original_track_name =
      track_string[@open_quote_index + 1..@init_close_quote_index - 1]
    # puts @original_track_name
    @track_other = track_string.gsub(@original_track_name, '')
    @new_track_string = ''
  end

  def rename_track(name_prefix, extension)
    new_name = "#{name_prefix}#{@track_num.rjust(3, '0')}.#{extension}"
    @new_track_string = @track_other.insert(@open_quote_index + 1, new_name)
    # puts @new_track_string
  end
end
