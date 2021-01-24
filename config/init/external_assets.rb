require 'sinatra/external_assets'

class FrontPainter
  include Sinatra::ExternalAssets::Magick

  def name
    'front.jpg'
  end

  def process(image)
    image.resize '800x450>'
    image.quality '70'
    image.compress 'JPEG'
    image.format :jpg
  end
end

class FullPainter
  include Sinatra::ExternalAssets::Magick

  def name
    'full.jpg'
  end

  def process(image)
    image.resize '600x800>'
    image.quality '80'
    image.compress 'JPEG'
    image.format :jpg
  end
end

class PreviewPainter
  include Sinatra::ExternalAssets::Magick

  def name
    'preview.jpg'
  end

  def process(image)
    image.thumbnail '180x180'
    image.quality '60'
    image.compress 'JPEG'
    image.format :jpg
  end
end

class TilePainter
  include Sinatra::ExternalAssets::Magick

  def name
    'tile.jpg'
  end

  def process(image)
    image.thumbnail '278x278'
    image.quality '70'
    image.compress 'JPEG'
    image.format :jpg
  end
end

module Init::ExternalAssets

  def self.registered(app)
    app.register Sinatra::ExternalAssets

    app.set :s3_key, ENV['S3_KEY']
    app.set :s3_secret, ENV['S3_SECRET']
    app.set :asset_bucket, ENV['S3_ASSET_BUCKET']
    app.set :cache_bucket, ENV['S3_CACHE_BUCKET']

    app.asset_painter :front, FrontPainter.new
    app.asset_painter :full, FullPainter.new
    app.asset_painter :preview, PreviewPainter.new
    app.asset_painter :tile, TilePainter.new

    app.asset_type :artwork, :front, :full, :preview, :tile
  end

end
