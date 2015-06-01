Rails.application.config.middleware.use OmniAuth::Builder do
  # GitHub
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], {
    redirect_uri: 'http://localhost:3000/auth/github/callback',
    scope: 'user'
  }

  # StackExchange - StackOverflow
  provider :stackexchange, ENV['SE_CLIENT_ID'], ENV['SE_CLIENT_SECRET'], public_key: ENV['SE_PUBLIC_KEY'], site: 'stackoverflow'

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
