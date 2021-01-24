class LeacockGallery < Padrino::Application

  register Init

  # register Padrino::Cache
  # enable :caching
  # set :cache, Padrino::Cache::Store::Memcache.new(
  #   ::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
  # set :cache, Padrino::Cache::Store::Memory.new(50)


  # Singleton instances
  # -------------------
  #

  helpers do
    def gallery
      @_gallery ||= Gallery.new
    end

    def calendar
      @_calendar ||= Calendar.new
    end
  end

  before do
    @gallery = exhibit(gallery)
    @calendar = exhibit(calendar)
  end

  get :index, map: '/' do
    @images = Image.front
    render 'application/index'
  end


  configure :development do
    # set :raise_errors, true
    # set :dump_errors, true
    set :show_exceptions, false
  end

end
