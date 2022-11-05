Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, "Iv1.bca2c66e759425d0", "3d0afc524f88b9024b14684f07bc1c9894ce9b54"
  end  
end
