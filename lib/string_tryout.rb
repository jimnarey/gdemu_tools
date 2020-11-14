# frozen_string_literal: false

require 'pp'

x = '1     0 4 2352 "Jet Grind Radio (USA) (Track 1).bin" 0'

name_start_i = x.index('"')
name_end_i = x.index('"', name_start_i + 1)

name = x[name_start_i + 1..name_end_i - 1]

y = x.gsub(name, '')

puts name
puts x
puts y
