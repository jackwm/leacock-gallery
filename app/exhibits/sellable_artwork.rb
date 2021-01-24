class SellableArtworkExhibit < Exhibit

  def self.applicable_to?(object)
    object.class == Artwork && object.for_sale?
  end

  def render_thumbnail_image(template)
    %[<img src="#{primary_image.url(:tile)}" class="product-thumb"/>]
  end

  def render_main_image(template)
    html = %[<a href="#{primary_image.url(:full)}" class="product-main">]
    html << %[<img src="#{primary_image.url(:full)}"/></a>]
  end

  def render_purchase_items(template)
    html = ''
    unless price.nil?
      html << '<dt class="detail-field">Price</dt>'
      html << '<dd class="detail-value">' + Grisaille::Money.new(price).to_s + '</dd>'
    end
    html << '<dt class="detail-field">Enquire</dt>'
    html << '<dd class="detail-value">'
    html << context.link_to('enquire', '#')
    html << '</dd>'
    html << '<dt class="detail-field">Purchase</dt>'
    html << '<dd class="detail-value" data-toggle="modal" data-target=".payment">'
    html << context.link_to('buy this artwork', '#payment')
    html << '</dd>'
    html << render_payment_modal(template)
  end

  def render_payment_modal(template)
    html = '<div class="payment modal hide">'
    html << '<div class="modal-header">'
    html << '<h3>Payment</h3></div>'
    html << '<div class="modal-body"><ul><li>You are about to purchase '
    html << '<strong>' + title + '</strong>' + ' by '
    artists.each do |artist|
      html << '<strong>' + artist.to_s + ' '
    end
    html << '</strong></li>'
    html << '<li>'
    html << paypal_code unless String(paypal_code).empty?
    html << '</li></ul></div></div>'
  end

end
