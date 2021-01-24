LeacockGallery.helpers do

  def process_exhibition_attrs(parms)
    attrs = parms.symbolize_keys
    attrs.only!(:title, :slug, :start_date, :end_date, :location, :details, :artists)

    attrs.delete(:slug) if !attrs[:slug].nil? && attrs[:slug].empty?
    if artists = attrs.delete(:artists)
      attrs[:artists] = artists.map { |slug| gallery.artist(slug: slug) }
    end

    attrs
  end

end
