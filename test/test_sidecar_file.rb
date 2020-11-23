# frozen_string_literal: false

require 'minitest/autorun'
require_relative '../lib/sidecar_file'

# paths = [
#   '/home/jimnarey/projects/gdemu_tools/test/fixtures/renaming/
#             gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/',
#   './fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/', # Not the same as in tryout_paths.rb
#   './test/fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/',
#   '/media/sf_G_DRIVE/Dreamcast Games/Sonic Adventure (USA) (En,Ja,Fr,De,Es) (Rev A)/'
# ]

# def test_path(path)
#   puts Dir.entries(path)
#   puts format('This path worked: %s', path)
# rescue StandardError => e
#   puts e
#   puts format('This path did not work: %s', path)
# end

# paths.each { |path| test_path(path) }

class TestSideCarFile < Minitest::Test
  def test_populates_contents
    expected = [
      '3',
      '1     0 4 2352 "Random Game (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 1).bin" 0',
      '2 14564 0 2352 "Random Game (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 2).bin" 0',
      '3 45000 4 2352 "Random Game (USA) (En,Ja,Fr,De,Es) (Rev A) (Track 3).bin" 0'
    ]

    # Directory/file not found!
    sidecar = SideCarFile.new('./test/fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A).gdi')

    assert_equal expected, sidecar.contents
  end
end
