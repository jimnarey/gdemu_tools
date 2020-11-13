# frozen_string_literal: false

# Text-based sidecar file, describing image contents
class SideCarFile
  attr_reader :contents

  def initialize(path)
    @path = path
    @contents = []
    populate_contents
    # print_contents
  end

  def populate_contents
    @contents = File.read(@path).split
    file = File.open(@path)
    @contents = file.readlines.map(&:chomp)
    file.close
  end

  def print_contents
    p @path
    p @contents
  end
end
