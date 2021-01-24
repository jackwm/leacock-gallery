LeacockGallery.helpers do

  def process_artist_attrs(parms)
    attrs = parms.symbolize_keys
    attrs.only!(:name, :slug, :biography)

    attrs.delete(:slug) if !attrs[:slug].nil? && attrs[:slug].empty?

    attrs
  end

end
