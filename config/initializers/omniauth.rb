Rails.application.config.middleware.use OmniAuth::Builder do
  # GitHub
  if ENV['RAILS_ENV'] == 'production'
    provider :github, ENV['GITHUB_KEY_PROD'], ENV['GITHUB_SECRET_PROD'], {
      redirect_uri: 'https://devboxtools.herokuapp.com/auth/github/callback',
      scope: 'user'
    }
  else
    provider :github, ENV['GITHUB_KEY_DEV'], ENV['GITHUB_SECRET_DEV'], {
      redirect_uri: 'http://localhost:3000/auth/github/callback',
      scope: 'user'
    }
  end

  # StackExchange - StackOverflow
  if ENV['RAILS_ENV'] == 'production'
    provider :stackexchange, ENV['SE_CLIENT_ID'], ENV['SE_CLIENT_SECRET'], public_key: ENV['SE_PUBLIC_KEY'], site: 'stackoverflow'
  else
    provider :stackexchange, ENV['SE_CLIENT_ID_PROD'], ENV['SE_CLIENT_SECRET_PROD'], public_key: ENV['SE_PUBLIC_KEY_PROD'], site: 'stackoverflow'
  end

  # GitLab
  provider :gitlab, ENV['GITLAB_KEY'], ENV['GITLAB_SECRET']

end

class NonExplodingFailureEndpoint
  attr_reader :env

  def self.call(env)
    new(env).call
  end

  def initialize(env)
    @env = env
  end

  def call
    redirect_to_failure
  end

  def raise_out!
    raise env['omniauth.error'] || OmniAuth::Error.new(env['omniauth.error.type'])
  end

  def redirect_to_failure
    message_key = env['omniauth.error.type']
    new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{message_key}"
    Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
  end
end

OmniAuth.config.on_failure = NonExplodingFailureEndpoint
