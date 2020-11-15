# frozen_string_literal: false

paths = [
  '/home/jimnarey/projects/gdemu_tools/test/fixtures/renaming/
            gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/',
  '../test/fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/',
  './test/fixtures/renaming/gdi_game/Random Game (USA) (En,Ja,Fr,De,Es) (Rev A)/',
  '/media/sf_G_DRIVE/Dreamcast Games/Sonic Adventure (USA) (En,Ja,Fr,De,Es) (Rev A)/'
]

def test_path(path)
  puts Dir.entries(path)
  puts format('This path worked: %s', path)
rescue StandardError => e
  puts e
  puts format('This path did not work: %s', path)
end

paths.each { |path| test_path(path) }
