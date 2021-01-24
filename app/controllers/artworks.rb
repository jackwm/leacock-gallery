LeacockGallery.controllers :artworks do

  # Filters
  # -------
  #

  before :new, :edit, :admin_index do
    dash.current_path = 'data>artworks'
  end

  before :show, :replace, :destroy, :edit do
    @artwork = exhibit(@gallery.artwork(slug: params[:slug]))
    if @artwork.nil?
      halt 404, "Unable to find an artwork at: #{params[:slug]}"
    end
  end


  # Display
  # -------
  #

  get :index do
    @artworks = exhibit(@gallery.artworks)
    render 'artworks/index'
  end

  get :follies, map: '/follies' do
    @artworks = exhibit(@gallery.follies)
    render 'artworks/follies'
  end

  get :show, map: '/artworks/:slug' do
    render 'artworks/show'
  end


  # Modification
  # ------------
  #

  post :create, map: '/admin/artworks' do
    attrs = process_artwork_attrs(params['artwork'])
    @artwork = exhibit(@gallery.new_artwork(attrs))
    if @artwork.register
      flash[:success] = alert('Successfully created artwork', @artwork)
      redirect url(:artworks, :admin_index)
    else
      flash[:error] = alert('Problems creating artwork', @artwork)
      redirect url(:artworks, :new)
    end
  end

  put :replace, map: '/admin/artworks/:slug' do
    attrs = process_artwork_attrs(params['artwork'])
    if @artwork.update(attrs)
      flash[:success] = alert('Successfully updated artwork', @artwork)
      redirect url(:artworks, :admin_index)
    else
      flash[:error] = alert('Problems updating artwork', @artwork)
      redirect back
    end
  end

  delete :destroy, map: '/admin/artworks/:slug' do
    if @artwork.unregister
      flash[:success] = alert('Successfully removed artwork', @artwork)
    else
      flash[:error] = alert('Unable to remove artwork', @artwork)
    end
    redirect url(:artworks, :admin_index)
  end


  # Admin views
  # -----------
  #

  before :new, :edit do
    @form = dash.prepare_form do |form|
      form.status :folly, :for_sale, :priced
      form.string :title, example: 'Face with Apropos', help: 'Title of work'
      form.slug
      form.choice :artists,
        choices: @gallery.artists,
        display: ->(artist) { [artist.slug, artist.name] },
        multiple: true,
        help: 'Artists credited with this work'
      form.choice :images,
        choices: Image.all,
        display: ->(image) { [image.s3_key, image.s3_key] },
        multiple: true,
        help: 'Images of this work'
      form.tab :extra, 'Extra' do
        form.string :dimensions, example: '1m x 20cm',
          help: 'Width x height [x depth], with units'
        form.string :weight, example: '500 g', help: 'Weight, with unit'
        form.string :media, example: 'Oil on canvas',
          help: 'Art media, freeform text'
      end
      form.tab :payment, 'Payment' do
        form.string :stock, example: 1,
          help: 'Number of items in stock; <code>0</code> means unavailable'
        form.string :price, example: '12000', help: 'Price, in cents'
        form.text :paypal_code,
          help: 'Paste the PayPal buy now button code here'
      end
      form.tab :blurb, 'Blurb' do
        form.markdown :blurb, help: 'Blurb describing the work'
      end
    end
  end

  get :new, map: '/admin/artworks/new' do
    @artwork = exhibit(@gallery.new_artwork)
    dash.make_creator(@artwork, @form)
  end

  get :edit, map: '/admin/artworks/:slug' do
    dash.make_editor(@artwork, @form)
  end

  get :admin_index, map: '/admin/artworks' do
    @artworks = exhibit(@gallery.artworks)
    dash.title = 'Artworks'
    dash.make_index(@artworks) do |artwork, table|
      table['Title'] = link_to(artwork.title, artwork.url)
      table['Artist(s)'] = artwork.render_artists_inline(self)
      table['Stock'] = artwork.stock
    end
  end

end
