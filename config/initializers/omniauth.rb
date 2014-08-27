Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret, {
    image_size: {width: 500, height: 500}
  }
 provider :linkedin, Rails.application.secrets.linkedin_id, Rails.application.secrets.linkedin_secret
  provider :google_oauth2, Rails.application.secrets.google_id, Rails.application.secrets.google_secret, { name: 'google', image_size: 'square' }
  
end
