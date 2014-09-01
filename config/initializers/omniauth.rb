Rails.application.config.middleware.use OmniAuth::Builder do
  keys = Rails.application.secrets
  provider :facebook, keys['facebook_id'], keys['facebook_secret'], {
    image_size: {width: 500, height: 500}
  }
  provider :linkedin, keys['linkedin_id'], keys['linkedin_secret'], {
    scope: 'r_fullprofile r_emailaddress', 
    fields: ['id', 'email-address', 'first-name', 'last-name', 'picture-url', "picture-urls::(original)"] 
  }
  provider :google_oauth2, keys['google_id'], keys['google_secret'], { 
    name: 'google', 
    image_aspect_ratio: 'square', 
    image_size: '500'
  }

end
