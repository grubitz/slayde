class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      dimensions = Paperclip::Geometry.from_file(value.queued_for_write[:original].path)
    rescue Paperclip::Errors::NotIdentifiedByImageMagickError
      return
    end
    width = options[:width]
    height = options[:height]

    record.errors[attribute] << I18n.t('picture.too_narrow', width: width) unless dimensions.width >= width
    record.errors[attribute] << I18n.t('picture.too_short', height: height) unless dimensions.height >= height
  end
end