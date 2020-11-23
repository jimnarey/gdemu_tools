# frozen_string_literal: false

# Class to hold each track in a GDI sidecar file
class GdiTrack
  attr_reader :track_name, :track_other

  def initialize(track_string)
    @track_string = track_string
    @track_num = @track_string.partition(' ').first
    @track_name_open_quote_index = track_string.index('"')
    @track_name_close_quote_index = track_string.index('"', @track_name_open_quote_index + 1)
    @track_name = track_string[@track_name_open_quote_index + 1..@track_name_close_quote_index - 1]
    @track_other = track_string.gsub(track_name, '')
    # @new_track_string = ''
  end

  def rename_track(name_prefix)
    puts '********Current Track String'
    puts @track_string
    puts '********Current Track Other'
    puts @track_other
    puts '********Track num'
    puts @track_num
    puts '********New name prefix'
    puts name_prefix
    new_name = @track_other.insert(@track_name_open_quote_index, name_prefix)
    puts '********New Name'
    puts new_name
    new_name += @track_num
    puts '********Combined Name'
    puts new_name
    @track_string = @track_other.insert(@track_name_open_quote_index, new_name)
    puts '********New Track String'
    puts @track_string
  end
end
