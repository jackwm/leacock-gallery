class Gallery
  extend Grisaille::Collection
  include Grisaille::Config

  is_a_collection_of :artists
  is_a_collection_of :artworks

  def title
    config['site.title']
  end

  def tagline
    config['gallery.tagline']
  end

  def phone
    config['gallery.phone']
  end

  def abn
    config['gallery.abn']
  end

  def follies
    Artwork.fetch_follies
  end
end
