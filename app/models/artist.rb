class Artist

  # Data schema
  # -----------
  #

  include DataMapper::Resource

  has n, :artworks,
    through: Resource
  has n, :exhibitions,
    through: Resource

  property :id, Serial
  timestamps :at

  property :name, String,
    required: true
  property :slug, Slug,
    required: true,
    default: ->(r,p){ r.name },
    unique: true
  property :biography, Text


  # Domain logic
  # ------------
  #

  attr_accessor :gallery

  def register
    return false unless valid?
    gallery.add_artist(self)
  end

  def update(attrs)
    gallery.update_artist(self, attrs)
  end

  def unregister
    gallery.destroy_artist(self)
  end

  def biography?
    !biography.nil?
  end
end
