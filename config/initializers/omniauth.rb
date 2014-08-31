Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'], {
    image_size: {width: 500, height: 500}
  }
  provider :linkedin, ENV['LINKEDIN_ID'], ENV['LINKEDIN_SECRET']
  provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET'], { name: 'google', image_aspect_ratio: 'square', image_size: '500' }
end
