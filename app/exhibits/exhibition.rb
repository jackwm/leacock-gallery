class ExhibitionExhibit < Exhibit
  def self.applicable_to?(object)
    object.class == Exhibition
  end

  exhibit_query :artists

  def to_s
    title
  end

  def url(type=:show)
    context.url_for(:exhibitions, type, :slug => slug)
  end

  def render_blurb(template)
    return nil unless details?
    context.md(details)
  end

  def render_snippet(template)
    return nil unless details?
    snippet(context.md(details), 100)
  end

  def render_artists(template)
    html = '<div class="detail"><span class="detail-field">'
    html << context.quantify('Artist', artists.count)
    html << '</span>'
    html << '<ul class="detail-value tag-list">'
    artists.each do |artist|
      html << '<li>'
      html << template.link_to(artist.name, artist.url, class: 'tag-item')
      html << '</li>'
    end
    html << '</ul></div>'
  end

  def render_dates(template)
    html = '<dt class="detail-field">Begins</dt>'
    html << '<dd class="detail-value">'
    html << start_date.strftime("%d/%b/%Y")
    html << '</dd>'
    html << '<dt class="detail-field">Ends</dt>'
    html << '<dd class="detail-value">'
    html << end_date.strftime("%d/%b/%Y")
    html << '</dd>'
  end

  def render_location(template)
    unless String(location).empty?
      html = '<dt class="detail-field">Location</dt>'
      html << '<dd class="detail-value">'
      html << '<a href="' + googlize(location) + '">'
      html << location
      html << '</a></dd>'
    end
  end

  def to_partial_path
    'exhibitions/exhibition'
  end
end
