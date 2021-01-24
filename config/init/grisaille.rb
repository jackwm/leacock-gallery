require 'grisaille/config'
require 'grisaille/dash'
require 'grisaille/blog'
require 'grisaille/pages'

require 'rack/yes_www'

Exhibit = Grisaille::Exhibit

Picaroon.register 'leacock-gallery', '1' do
  exhibit Padrino.root('app/exhibits')
  factory Padrino.root('app/factories')
  sprockets Padrino.root('app/assets')
  view Padrino.root('app/views')
end

class LGTagger < Sinatra::Markdown::BasicTagger
  %w(artist artwork).each do |tag|
    define_method(tag) do |pos, kwd|
      slug = pos.first
      raise ArgumentError, "The {{#{tag}}} tag needs a slug" if slug.nil?
      app.url(tag.pluralize.to_sym, :show, slug: slug)
    end
  end
end

module Init::Grisaille

  def self.registered(app)
    app.use Picaroon::Assets, :sprockets => Padrino.root

    app.set :md_tagger, LGTagger.new(app)

    app.config do |cfg|
      cfg.str 'site.title', 'Leacock Gallery'
      cfg.str 'gallery.email', 'enquiries@leacockgallery.com',
        "Main enquiry email address"
      cfg.str 'gallery.tagline', 'Fine Art & Follies', "Site's subtitle/tagline"
      cfg.str 'gallery.phone', '0435 150 501', "Contact phone number"
      cfg.str 'gallery.abn', '83 865 028 121', "ABN"
      cfg.int 'artwork.folly', 10000,
        'The threshold price for follies, in cents'
    end

    app.dash.navbar do |nav|
      nav.delete 'data>chunks'
      # nav.append 'newsletter', 'Newsletter'
      nav.append 'data', 'Manage data'
      nav.before 'data>super', 'data>artists', 'Artists', app.url(:artists, :admin_index)
      nav.before 'data>super', 'data>artworks', 'Artworks', app.url(:artworks, :admin_index)
      nav.before 'data>super', 'data>exhibs', 'Exhibitions', app.url(:exhibitions, :admin_index)
      nav.before 'data>super', 'data>div1', :divider
      nav.before 'data>super', 'data>media', 'Media', app.url(:media, :admin_index)
    end
  end

end
