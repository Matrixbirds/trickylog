Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

OmniAuth.configure do |config|
  config.path_prefix           = '/login'
  # config.on_failure            = nil
end
