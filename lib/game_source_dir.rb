# frozen_string_literal: false

require_relative 'sidecar_file'

# A source directory containing a single Dreamcast game
# Some sense checking that this is the case
class GameSourceDir
  attr_reader :image_filepath_collections, :sidecar_filepath_collections, :sidecar_file_collections

  def initialize(path)
    @path = path
    @image_filepath_collections = find_filepaths_by_extension('bin', 'img', 'sub', 'mdf', 'iso')
    @sidecar_filepath_collections = find_filepaths_by_extension('gdi', 'cue', 'cdi', 'ccd', 'mds')
    @sidecar_file_collections = {}
    load_sidecar_files
  end

  def find_filepaths_by_extension(*args)
    filepaths = {}
    # Check Ruby caches calls like this
    args.each { |arg| filepaths[arg] = get_files_by_type(arg) unless get_files_by_type(arg).empty? }
    filepaths
  end

  def get_files_by_type(extension)
    Dir.glob("#{@path}/*.#{extension}", File::FNM_CASEFOLD)
  end

  def load_sidecar_files
    @sidecar_filepath_collections.each do |extension, filepath_collection|
      @sidecar_file_collections[extension] = []
      filepath_collection.each do |filepath|
        @sidecar_file_collections[extension].append(SideCarFile.new(filepath))
      end
    end
  end

  def process_gdi_set
    gdi_contents = @sidecar_file_collections['gdi'][0].contents
    puts gdi_contents
  end
end
