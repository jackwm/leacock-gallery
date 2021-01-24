LeacockGallery.controllers :exhibitions do

  # Filters
  # -------
  #

  before :new, :edit, :admin_index do
    dash.current_path = 'data>exhibs'
  end

  before :show, :replace, :destroy, :edit do
    @exhibition = exhibit(@calendar.exhibition(slug: params[:slug]))
    if @exhibition.nil?
      halt 404, "Unable to find exhibition at: #{params[:slug]}"
    end
  end


  # Display
  # -------
  #

  get :index do
    @exhibitions = @calendar.exhibitions
    render 'exhibitions/index'
  end

  get :show, map: '/exhibitions/:slug' do
    render 'exhibitions/show'
  end


  # Modification
  # ------------
  #

  post :create, map: '/admin/exhibitions' do
    attrs = process_exhibition_attrs(params['exhibition'])
    @exhibition = exhibit(@calendar.new_exhibition(attrs))
    if @exhibition.schedule
      flash[:success] = alert('Successfully created exhibition', @exhibition)
      redirect url(:exhibitions, :admin_index)
    else
      flash[:error] = alert('Problems creating exhibition', @exhibition)
      redirect url(:exhibitions, :new)
    end
  end

  put :replace, map: '/admin/exhibitions/:slug' do
    attrs = process_exhibition_attrs(params['exhibition'])
    if @exhibition.update(attrs)
      flash[:success] = alert('Successfully updated exhibition', @exhibition)
      redirect url(:exhibitions, :admin_index)
    else
      flash[:error] = alert('Problems updating exhibition', @exhibition)
      redirect back
    end
  end

  delete :destroy, map: '/admin/exhibitions/:slug' do
    if @exhibition.cancel
      flash[:success] = alert('Successfully cancelled exhibition', @exhibition)
    else
      @exhibition.reload
      flash[:error] = alert('Unable to cancel exhibition', @exhibition)
    end
    redirect url(:exhibtiions, :admin_index)
  end


  # Admin views
  # -----------
  #

  before :new, :edit do
    @form = dash.prepare_form do |form|
      form.string :title, help: 'The exhibition title',
        example: 'Collective Extravaganza: 15 Years of Misfortune'
      form.slug
      form.choice :artists,
        choices: @gallery.artists,
        display: ->(artist) { [artist.slug, artist.name] },
        multiple: true,
        help: 'Artists participating in this exhibition'
      form.tab :location, 'Location' do
        form.string :start_date, example: '2011-11-21',
          help: 'Start date in YYYY-MM-DD format'
        form.string :end_date, example: '2011-11-21',
          help: 'End date in YYYY-MM-DD format'
        form.string :location, example: '123 Fake St, Faketown, NSW Australia',
          help: 'The location of the exhibition, freeform text'
      end
      form.tab :details, 'Details' do
        form.markdown :details, help: 'Further details about the event'
      end
    end
  end

  get :new, map: '/admin/exhibitions/new' do
    @exhibition = exhibit(@calendar.new_exhibition)
    dash.make_creator(@exhibition, @form)
  end

  get :edit, map: '/admin/exhibitions/:slug' do
    dash.make_editor(@exhibition, @form)
  end

  get :admin_index, map: '/admin/exhibitions' do
    @exhibitions = exhibit(@calendar.exhibitions)
    dash.title = 'Exhibitions'
    dash.make_index(@exhibitions) do |exhibition, table|
      table['Title'] = link_to(exhibition.title, exhibition.url)
      table['Artists'] = exhibition.artists.size
    end
  end
end
