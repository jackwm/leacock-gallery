class ImageExhibit < Exhibit

  def self.applicable_to?(object)
    object.is_a?(Image)
  end

  exhibit_query :artworks
  exhibit_query :primary_artist
  exhibit_query :primary_artwork

  def to_s
    s3_key
  end

  def to_partial_path
    'media/image'
  end

  def render_artworks_inline(template)
    ''.tap do |html|
      if cullable?
        html << 'This image is not being used. '
        html << %[<a href="/admin/media/#{s3_key}" class="btn btn-small btn-warning" ]
        html << %[data-confirm="Really delete '#{to_s}'?" data-method="delete">]
        html << template.icon(:trash) + 'delete it</a>'
      else
        html << artworks.map do |a|
          %[<a href="#{a.url(:edit)}" title="#{a.title}">#{a.title}</a>]
        end.to_sentence
      end
    end
  end

  def render_preview(template)
    ''.tap do |html|
      if missing?
        html << 'This image is missing but still in use. '
        html << %[<a href="/admin/media/#{s3_key}" class="btn btn-small btn-danger" ]
        html << %[data-confirm="Really delete '#{to_s}'?" data-method="delete">]
        html << template.icon(:trash) + 'delete it</a>'
      else
        html << %[<a href="#{url(:full)}"><img src="#{url(:preview)}" alt="" /></a>]
      end
    end
  end

  def state_class
    return 'error' if missing?
    return 'warning' if cullable?
    nil
  end

end
