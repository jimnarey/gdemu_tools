# frozen_string_literal: false

# Class to hold each track in a GDI sidecar file
class GdiTrack
  attr_reader :track_name, :track_other

  def initialize(track_string)
    @original_track_string = track_string
    @track_num = track_string.partition(' ').first
    @original_track_name_open_quote_index = track_string.index('"')
    @original_track_name_close_quote_index = track_string.index('"', @original_track_name_open_quote_index + 1)
    @original_track_name = track_string[@original_track_name_open_quote_index + 1..@original_track_name_close_quote_index - 1]
    @track_other = track_string.gsub(@original_track_name, '')
    # @new_track_string = ''
  end

  def rename_track(name_prefix, extension)
    new_name = name_prefix + @track_num + '.' + extension
    new_name = @track_other.insert(@original_track_name_open_quote_index + 1, new_name)
    puts '********New Track String'
    puts new_name
  end
end
