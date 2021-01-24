LeacockGallery.controllers :media do

  before do
    dash.current_path = 'data>media'
  end

  get :admin_index, map: '/admin/media' do
    @images = exhibit(Image.displayable)
    render 'media/index', layout: 'grisaille/dash'
  end

  put :front, map: '/admin/media/front' do
    image = Image.first(:s3_key => params[:key])
    image.update(:front => params[:front] == 'on')
    if image.save
      flash[:success] = alert('Changed front page status', image)
    else
      flash[:error] = alert('Problems changing front page status', image)
    end
    redirect url(:media, :admin_index)
  end

  delete %r{/admin/media/(.+)} do
    key = params[:captures].first
    image = Image.first(:s3_key => key)
    if image.destroy
      flash[:success] = alert('Successfully removed the image', image)
    else
      flash[:error] = alert('Unable to remove the image', image)
    end
    redirect url(:media, :admin_index)
  end

end
