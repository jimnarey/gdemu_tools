# frozen_string_literal: false

# Class to hold each track in a GDI sidecar file
class GdiTrack
  def initialize(track_string)
    @track_string = track_string
    @track_name_open_quote_index = track_string.index('"')
    @track_name_close_quote_index = track_string.index('"', @track_name_open_quote_index + 1)
    @track_name = track_string[@track_name_open_quote_index + 1..@track_name_close_quote_index - 1]
    @track_other = track_string.gsub(track_string, '')
    display_stuff
  end

  def display_stuff
    puts @track_string
    # puts @track_name_open_quote_index
    # puts @track_name_close_quote_index
    puts @track_name
    puts @track_other
  end
end