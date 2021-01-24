Padrino.configure_apps do
  set :session_secret,
    'ba69b0fb7be2c8366047b2c467afcb212bf48d7cea73456ef5bc38bb9e2597e0'
end

Padrino.mount("LeacockGallery").to('/')
