require 'forwardable'

class Image

  # Data schema
  # -----------
  #

  include DataMapper::Resource

  has n, :artworks,
    through: Resource

  property :s3_key, String,
    key: true

  property :front, Boolean,
    required: true,
    default: false
  property :missing, Boolean,
    required: true,
    default: false


  # Delegation
  # ----------
  #

  extend Forwardable

  def to_asset
    LeacockGallery.Assets(:artwork).asset(s3_key)
  end

  def_delegators :to_asset,
    :url, :exists?, :generate, :delete, :clear!


  # Hooks
  # -----
  #

  before :destroy, :delete

  after :save, :warm_cache

  def warm_cache
    clear!
    types = [:full, :preview, :tile]
    types << :front if front?
    generate(*types)
  end


  # Domain logic
  # ------------
  #

  def cullable?
    artworks.none? && !front?
  end

  def front?
    front && !primary_artist.nil?
  end

  def missing?
    missing
  end


  # Class-level domain logic
  # ------------------------
  #

  def self.cullable
    all(:artwork_images => nil, :front => false)
  end

  def self.displayable
    all - garbage_collectable
  end

  def self.front
    all(:front => true)
  end

  def self.garbage_collectable
    cullable & missing
  end

  def self.missing
    all(:missing => true)
  end

  def primary_artwork
    artworks.first
  end

  def primary_artist
    primary_artwork && primary_artwork.primary_artist
  end

  def self.pull
    all.each do |image|
      image.missing = true
      image.save!
    end
    LeacockGallery.all_asset_keys.each do |key|
      image = first_or_new(:s3_key => key)
      image.missing = false
      image.saved? ? image.save! : image.save
    end
    garbage_collectable.each { |image| image.destroy }
  end

end
