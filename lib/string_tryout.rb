# frozen_string_literal: false

require 'pp'

x = '1     0 4 2352 "Jet Grind Radio (USA) (Track 1).bin" 0'

name_start_i = x.index('"')
name_end_i = x.index('"', name_start_i + 1)

name = x[name_start_i..name_end_i]
x.slice! name
name = name.delete_prefix('"').delete_suffix('"')
# name.gsub(/"/, '')

puts name
y = x.split
puts y
