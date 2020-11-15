# frozen_string_literal: false

require 'minitest/autorun'
require_relative '../lib/sidecar_file'

# Try work out what the right path is
# None of these work
puts Dir.entries('/home/jimnarey/projects/gdemu_tools/test/fixtures/renaming/
      gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/')

puts Dir.entries('./fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/')

puts Dir.entries('./test/fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/')

# This one works
puts Dir.entries('/media/sf_G_DRIVE/Dreamcast Games/Sonic Adventure (USA) (En,Ja,Fr,De,Es) (Rev A)/')

class TestSideCarFile < Minitest::Test
  def test_populates_contents
    expected = [
      '3',
      '1     0 4 2352 "Sonic Adventure (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 1).bin" 0',
      '2 14564 0 2352 "Sonic Adventure (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 2).bin" 0',
      '3 45000 4 2352 "Sonic Adventure (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 3).bin" 0'
    ]

    # Directory/file not found!
    sidecar = SideCarFile.new('./fixtures/renaming/
      gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A).gdi')

    assert_equal expected, sidecar.contents
  end
end
