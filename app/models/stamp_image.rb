class StampImage < ActiveRecord::Base
  attr_accessible :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  
  belongs_to :user
  has_many :stamps, :dependent => :nullify
  
  has_attached_file :photo, :url  => "/assets/stamp_images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/stamp_images/:id/:style/:basename.:extension"
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 3.megabytes
  
  validates_presence_of :user_id
  
  def generate_graphics
    STAMP_COLORS.each do |color|
      generate_graphic_for_color(color)
    end
    update_attribute(:generated_at, Time.now)
  end
  
  def generate_graphic_for_color(color)
    source = Magick::Image.read(photo.path).first
    stamp_overlay = Magick::Image.read("#{RAILS_ROOT}/public/images/stamp_image_overlay.png").first
    source.resize_to_fill!(stamp_overlay.columns, stamp_overlay.rows)
    source = source.quantize(256, Magick::GRAYColorspace).contrast(true)
    source.composite!(stamp_overlay, Magick::CenterGravity, 0, 0, Magick::OverCompositeOp)
    colored = Magick::ImageList.new
    colored.new_image(70, 70) { self.background_color = color }
    source.matte = false
    colored.composite!(source.negate, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)
    File.delete(photo.path(color)) if File.exist? photo.path(color)
    FileUtils.mkdir_p(File.dirname(photo.path(color))) unless File.exist? File.dirname(photo.path(color))
    colored.write(photo.path(color))
  end
end
