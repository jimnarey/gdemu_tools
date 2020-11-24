# frozen_string_literal: false

require_relative 'sidecar_file'

# A source directory containing a single Dreamcast game
# Some sense checking that this is the case
class GameSourceDir
  attr_reader :image_filepath_collections, :sidecar_filepath_collections, :sidecar_file_collections, :sidecar_files

  def initialize(path)
    @path = path
    @image_filepath_collections = find_filepaths_by_extension('bin', 'img', 'sub', 'mdf', 'iso')
    @sidecar_filepath_collections = find_filepaths_by_extension('gdi', 'cue', 'cdi', 'ccd', 'mds')
    @sidecar_files = {}
    load_sidecar_files
    # pp @sidecar_files
  end

  # Find all relevant files in folder
  def find_filepaths_by_extension(*args)
    filepaths = {}
    args.each { |arg| filepaths[arg] = get_files_by_type(arg) unless get_files_by_type(arg).empty? }
    filepaths
  end

  # Find all files with same extension, irrespective of extension case
  def get_files_by_type(extension)
    Dir.glob("#{@path}/*.#{extension}", File::FNM_CASEFOLD)
  end

  # Duplicate collections of sidecar filepaths with respective sidecar objects
  def load_sidecar_files
    @sidecar_filepath_collections.each do |extension, filepath_collection|
      # puts extension
      # Consider adding back sense check
      if @sidecar_filepath_collections[extension].length > 1
        puts "More than one sidecar file with #{extension} extension, using first found"
      end
      @sidecar_files[extension] = provide_sidecar(extension, filepath_collection[0])
    end
  end

  def gdi_rename
    @sidecar_files['gdi'].rename_tracks
  end

  def gdi_write
    @sidecar_files['gdi'].write_tracks
  end

  def gdi_names
    # all_names = []
    names = @sidecar_files['gdi'].names
    puts '********Names'
    pp names
    # @sidecar_file_collections['gdi'].each { |gdi_side_car| all_names.append(gdi_side_car.original_file_names) }
  end
end
