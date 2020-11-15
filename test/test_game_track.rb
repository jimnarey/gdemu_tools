# frozen_string_literal: false

require 'minitest/autorun'
require_relative '../lib/game_track'

# Test class
class TestGdiTrack < Minitest::Test
  def test_extracts_name
    gdi_track = GdiTrack.new('1     0 4 2352 "Random Game (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 1).bin" 0')
    assert_equal 'Random Game (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 1).bin', gdi_track.track_name
  end
end
