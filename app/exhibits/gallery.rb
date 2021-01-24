class GalleryExhibit < Exhibit
  def self.applicable_to?(object)
    object.class == Gallery
  end

  exhibit_query :artists
  exhibit_query :artworks
  exhibit_query :follies
end
