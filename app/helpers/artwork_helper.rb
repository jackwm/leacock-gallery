LeacockGallery.helpers do

  def process_artwork_attrs(parms)
    attrs = parms.symbolize_keys
    attrs.only!(:title, :slug, :weight, :dimensions, :blurb, :price,
                :media, :artists, :images, :paypal_code, :stock)

    if dimensions = attrs.delete(:dimensions)
      times = ["&times;", "&#215;", "\u00D7", ?X]
      times.each {|time| dimensions.gsub!(time, ?x) }
      dims = dimensions.split(/\s*x\s*/)
      attrs[:width], attrs[:height], attrs[:depth] = dims
    end
    artists = attrs.fetch(:artists, [])
    attrs[:artists] = artists.map { |slug| gallery.artist(slug: slug) }.compact
    images = attrs.fetch(:images, [])
    attrs[:images] = images.map { |key| Image.first(:s3_key => key) }.compact

    attrs[:price] = nil if attrs[:price].blank?
    attrs.delete(:slug) if attrs[:slug].blank?
    attrs.delete(:stock) if attrs[:stock].blank?

    attrs
  end

end
