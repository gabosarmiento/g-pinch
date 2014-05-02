# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  process :set_content_type
  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog
  after :remove, :delete_empty_upstream_dirs
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  # From 
  def make_thumbnail(width, height)
    # uses MiniMagick classes to get a square, centered thumbnail image
    manipulate! do |img|
      if img[:width] < img[:height]
        remove = ((img[:height] - img[:width])/2).round
        img.shave("0x#{remove}")
      elsif img[:width] > img[:height]
        remove = ((img[:width] - img[:height])/2).round
        img.shave("#{remove}x0")
      end

      img.resize("#{width}x#{height}")
      img
    end        
  end

  # Create different versions of your uploaded files:
   version :normal do
    process :efficient_conversion => [640, 960]
  end

  version :thumb do
    process :make_thumbnail => [192, 192]
    process :quality => 85 # this reduces filesize greatly and saves space
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir

  rescue SystemCallError
    true # nothing, the dir is not empty
  end

  private
  
  def efficient_conversion(width, height)
    manipulate! do |img|
      img.combine_options do |c|
        c.fuzz        "3%"
        c.trim
        c.resize      "#{width}x#{height}>"
        c.resize      "#{width}x#{height}<"
      end
      img
    end
  end
  # Adding watermark to photos
  # process :watermark => "#{RAILS_ROOT}/public/images/watermark.png"
  # def watermark(path_to_file)
  #   manipulate! do |img|
  #     img = img.composite(MiniMagick::Image.open(path_to_file), "jpg") do |c|
  #       c.gravity "Center"
  #        c.draw "rotate 325 text 85,-30 'pepperpinch'"
  #         c.font "#{Rails.root}/public/images/fonts/Vera.ttf"
  #         c.fill("lightgray")
  #         c.pointsize '60' 
  #     end
  #   end
  # end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
