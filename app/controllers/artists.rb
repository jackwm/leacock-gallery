LeacockGallery.controllers :artists do

  # Filters
  # -------
  #

  before :new, :edit, :admin_index do
    dash.current_path = 'data>artists'
  end

  before :show, :replace, :destroy, :edit do
    @artist = exhibit(@gallery.artist(slug: params[:slug]))
    if @artist.nil?
      halt 404, "Unable to find an artist at: #{params[:slug]}"
    end
  end


  # Display
  # -------
  #

  get :index do
    @artists = exhibit(@gallery.artists)
    render 'artists/index'
  end

  get :show, map: '/artists/:slug' do
    render 'artists/show'
  end


  # Modification
  # ------------
  #

  post :create, map: '/admin/artists' do
    attrs = process_artist_attrs(params['artist'])
    @artist = exhibit(@gallery.new_artist(attrs))
    if @artist.register
      flash[:success] = alert('Successfully created artist', @artist)
      redirect url(:artists, :admin_index)
    else
      flash[:error] = alert('Problems creating artist', @artist)
      redirect url(:artists, :new)
    end
  end

  put :replace, map: '/admin/artists/:slug' do
    attrs = process_artist_attrs(params['artist'])
    if @artist.update(attrs)
      flash[:success] = alert('Successfully updated artist', @artist)
      redirect url(:artists, :admin_index)
    else
      flash[:error] = alert('Problems updating artist', @artist)
      redirect back
    end
  end

  delete :destroy, map: "/admin/artists/:slug" do
    if @artist.unregister
      flash[:success] = alert('Successfully removed artist', @artist)
    else
      flash[:error] = alert('Unable to remove artist', @artist)
    end
    redirect url(:artists, :admin_index)
  end


  # Admin views
  # -----------
  #

  before :new, :edit do
    @form = dash.prepare_form do |form|
      form.string :name, example: 'John Smith', help: 'Full name'
      form.slug
      form.markdown :biography, help: 'Artist biography'
    end
  end

  get :new, map: '/admin/artists/new' do
    @artist = exhibit(@gallery.new_artist)
    dash.make_creator(@artist, @form)
  end

  get :edit, map: '/admin/artists/:slug' do
    dash.make_editor(@artist, @form)
  end

  get :admin_index, map: '/admin/artists' do
    @artists = exhibit(@gallery.artists)
    dash.title = 'Artists'
    dash.make_index(@artists) do |artist, table|
      table['Name'] = link_to(artist.name, artist.url)
      table['Artworks'] = artist.artworks.size
    end
  end
end
