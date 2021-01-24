class Artwork

  # Data schema
  # -----------
  #

  include DataMapper::Resource

  has n, :artists,
    through: Resource
  has n, :images,
    through: Resource

  property :id, Serial
  timestamps :at

  property :title, String,
    required: true,
    length: 500
  property :slug, Slug,
    required: true,
    default: ->(r,p){ r.title  },
    unique: true

  property :media, String

  property :width, String,
    lazy: [:dimensions]
  property :height, String,
    lazy: [:dimensions]
  property :depth, String,
    lazy: [:dimensions]
  property :weight, String,
    lazy: [:dimensions]

  property :stock, Integer,
    required: true,
    default: 1

  property :blurb, Text

  property :price, Integer,
    default: 0

  property :paypal_code, Text


  # Domain logic
  # ------------
  #

  attr_accessor :gallery

  def register
    return false unless valid?
    gallery.add_artwork(self)
  end

  def update(attrs)
    gallery.update_artwork(self, attrs)
  end

  def unregister
    gallery.destroy_artwork(self)
  end


  def blurb?
    blurb && !blurb.empty?
  end

  def multiple_images?
    secondary_images.any?
  end

  def folly?
    price.present? && price <= self.class.folly_threshold
  end

  def for_sale?
    !new? && stock > 0
  end

  def priced?
    price.present?
  end


  # TODO move to exhibit
  def dimensions
    [width, height, depth].compact.join(" \u00D7 ")
  end

  def primary_artist
    artists.first
  end

  # TODO move to exhibit
  def primary_image
    images.first || self.class.default_image
  end

  # TODO move to exhibit
  def secondary_images
    images - [primary_image]
  end

  def artists
    super.map do |artist|
      artist.tap { |a| a.gallery = gallery }
    end
  end


  # Class-level domain logic
  # ------------------------
  #

  def self.default_image
    Piffle.image_object(text: '(no image)', width: 500, height: 800)
  end

  def self.fetch_follies
    all(:price.lte => folly_threshold)
  end

  def self.folly_threshold
    Grisaille::Config['artwork.folly']
  end

end
