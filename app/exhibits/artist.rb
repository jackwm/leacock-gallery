class ArtistExhibit < Exhibit
  def self.applicable_to?(object)
    object.class == Artist
  end

  exhibit_query :artworks

  def to_s
    name
  end

  def url(type=:show)
    context.url_for(:artists, type, :slug => slug)
  end

  def render_biography_jump(template)
    return nil unless biography?
    html = '<a class="content-jump" href="#bio">'
    html << template.icon(:hand_down) + 'Biography</a>'
  end

  def render_biography(template)
    return nil unless biography?
    html = '<article id="bio" class="content"><h1>Biography</h1>'
    html << context.md(biography)
    html << '</article>'
  end

  def render_artwork_images(template)
    html = '<div class="carousel slide js-oeuvre"><div class="carousel-inner">'
    artworks.each_with_index do |artwork, index|
      html << %[<div class="item #{'active' if index.zero?}">]
      html << artwork.render_thumbnail_image(template)
      html << '</div>'
    end
    html << '</div></div>'
  end

  def to_partial_path
    'artists/artist'
  end
end
