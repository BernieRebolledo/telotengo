Rails.application.config.middleware.use OmniAuth::Builder do

	# Configuración de la conexión a fb
	# FB_ID = "1644141235820590"
	# FB_SECRET = "8846589eb6fbe734fd6d1c9803a301df"
	provider :facebook, ENV["FB_ID"], ENV["FB_SECRET"], :image_size => "large"
	


	# TW_ID = "i5JnnAx46k2T0PgXzYmcpPw5O"
	# TW_SECRET = "0bpmoiAeMcM29WxYoINgvT2J9c7sayCTR4Y1c2CcUbO9LnrnTA"
	provider :twitter, ENV["TW_ID"], ENV["TW_SECRET"], 
	{
	:image_size => 'original'	
	}
	# Por si falla fb o tw

	on_failure { |env| ApplicationController.action(:connect).call(env)}
    
    # provider :developer unless Rails.env.production?

  	

end