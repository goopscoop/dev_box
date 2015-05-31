Rails.application.config.middleware.use OmniAuth::Builder do
  # GitHub
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], {
    redirect_uri: 'http://localhost:3000/auth/github/callback',
    scope: 'user'
  }

  # StackExchange - StackOverflow
  # provider :stackexchange, "client_id", "client_secret", public_key: "key", site: 'stackoverflow'
  provider :stackexchange, ENV['SE_CLIENT_ID'], ENV['SE_CLIENT_SECRET'], public_key: ENV['SE_PUBLIC_KEY'], site: 'stackoverflow'#, {
  #  redirect_uri: 'http://localhost:3000/auth/github/callback'
  #}

  # GitLab

end
