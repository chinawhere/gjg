# coding: utf-8
class UserLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  #  include CarrierWave::Compatibility::Paperclip
  include Piet::CarrierWaveExtension

  process :optimize

  storage :file

  def store_dir
    "upload/users/logo/#{("%09d" % model.id).scan(/\d{3}/).join("/")}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:

  def default_url
    "/images/logos/user/" + [version_name,"logo.png"].compact.join('_')
  end

  version :lager do
    process :resize_to_fill => [180, 200]
  end


  version :medium do
    process resize_to_fill: [90, 100]
  end

  version :feed do
    process resize_to_fill: [45, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    @name ||= "#{md5}.#{file.extension}" if original_filename.present?
  end

  protected
  def md5
    var = :"@#{mounted_as}_md5"
    model.instance_variable_get(var) or model.instance_variable_set(var, ::Digest::MD5.file(current_path).hexdigest)
  end
end
