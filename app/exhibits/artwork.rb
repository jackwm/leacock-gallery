class ArtworkExhibit < Exhibit
  def self.applicable_to?(object)
    object.class == Artwork
  end

  exhibit_query :artists
  exhibit_query :primary_artist

  def to_partial_path
    'artworks/artwork'
  end

  def to_s
    title
  end

  def url(type=:show)
    context.url_for(:artworks, type, :slug => slug)
  end


  def render_artists(template)
    template.partial('artworks/artist_credit', locals: {artists: artists})
  end

  def render_artists_inline(template)
    artists.map do |a|
      %[<a href="#{a.url}" title="#{a.name}">#{a.name}</a>]
    end.to_sentence
  end

  def render_blurb(template)
    return nil unless blurb?
    ''.tap do |html|
      html << '<article id="details" class="content">'
      html << '<h1>Details</h1>'
      html << context.md(blurb)
      html << '</article>'
    end
  end

  def render_blurb_jump(template)
    return nil unless blurb?
    html = '<a class="content-jump" href="#details">'
    html << template.icon(:hand_down) + 'More information</a>'
  end

  def render_dimensions_item(template)
    dims = [width, height]
    return '' if dims.compact.empty?
    dims.push(depth) unless depth.nil?
    html = '<dt class="detail-field">Dimensions</dt>'
    html << '<dd class="detail-value">'
    html << dims.compact.map(&:to_s).join(" &times; ") + '</dd>'
  end

  def render_main_image(template)
    ''.tap do |html|
      html << '<div class="product-overlay">'
      html << '<i class="product-sold js-sold-dot" data-placement="left" title="sold"></i>'
      html << %[<a href="#{primary_image.url(:full)}" class="product-main">]
      html << %[<img src="#{primary_image.url(:full)}"/></a>]
      html << '</div>'
    end
  end

  def render_media_item(template)
    html = %[<dt class="detail-field">Media</dt><dd class="detail-value">#{media}</dd>]
    media.nil? ? '' : html
  end

  def render_popover_content(template)
    ''.tap do |html|
      html << '<dl class="detail detail-unlabeled">'
      html << render_artists(template)
      html << render_media_item(self)
      html << '</dl>'
    end
  end

  def render_purchase_items(template)
    '<dt class="detail-field">Status</dt>' + '<dd class="detail-value">sold</dd>'
  end

  def render_secondary_images(template)
    ''.tap do |html|
      html << '<div class="product-secondaries">'
      secondary_images.each do |image|
        html << %[<a href="#{image.url(:full)}" class="product-secondary">]
        html << %[<img src="#{image.url(:preview)}"/></a>]
      end
      html << '</div>'
    end
  end

  def render_thumbnail_image(template)
    ''.tap do |html|
      html << '<div class="product-overlay">'
      html << '<i class="product-sold js-sold-dot" data-placement="left" title="sold"></i>'
      html << %[<img src="#{primary_image.url(:tile)}" class="product-thumb"/>]
      html << '</div>'
    end
  end

end
