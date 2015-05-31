class AuthController < ApplicationController

  # auth_logout GET
  def logout
  end

  # auth_failure GET
  def failure
    failure = {failure: "Uh oh! Looks like something didn't go quite right."}
    render json: failure
  end

  # GET
  def callback

    puts "AUTH CALLBACK HIT"
    provider_user = request.env['omniauth.auth']
    render json: provider_user

  end

end


# GitHub Reply

# {
#   provider: "github",
#   uid: "6178896",
#   info: {
#     nickname: "ncronquist",
#     email: "nick@ncronquist.com",
#     name: "Nicholas Cronquist",
#     image: "https://avatars.githubusercontent.com/u/6178896?v=3",
#     urls: {
#       GitHub: "https://github.com/ncronquist",
#       Blog: ""
#     }
#   },
#   credentials: {
#     token: "9132e59031dbd48cfb25f82142c16ecaf194dc8a",
#     expires: false
#   },
#   extra: {
#     raw_info: {
#       login: "ncronquist",
#       id: 6178896,
#       avatar_url: "https://avatars.githubusercontent.com/u/6178896?v=3",
#       gravatar_id: "",
#       url: "https://api.github.com/users/ncronquist",
#       html_url: "https://github.com/ncronquist",
#       followers_url: "https://api.github.com/users/ncronquist/followers",
#       following_url: "https://api.github.com/users/ncronquist/following{/other_user}",
#       gists_url: "https://api.github.com/users/ncronquist/gists{/gist_id}",
#       starred_url: "https://api.github.com/users/ncronquist/starred{/owner}{/repo}",
#       subscriptions_url: "https://api.github.com/users/ncronquist/subscriptions",
#       organizations_url: "https://api.github.com/users/ncronquist/orgs",
#       repos_url: "https://api.github.com/users/ncronquist/repos",
#       events_url: "https://api.github.com/users/ncronquist/events{/privacy}",
#       received_events_url: "https://api.github.com/users/ncronquist/received_events",
#       type: "User",
#       site_admin: false,
#       name: "Nicholas Cronquist",
#       company: "",
#       blog: "",
#       location: "Seattle, WA",
#       email: "nick@ncronquist.com",
#       hireable: true,
#       bio: null,
#       public_repos: 16,
#       public_gists: 6,
#       followers: 1,
#       following: 0,
#       created_at: "2013-12-13T14:11:45Z",
#       updated_at: "2015-05-30T06:57:28Z",
#       private_gists: 1,
#       total_private_repos: 1,
#       owned_private_repos: 0,
#       disk_usage: 13528,
#       collaborators: 0,
#       plan: {
#         name: "free",
#         space: 976562499,
#         collaborators: 0,
#         private_repos: 0
#       }
#     }
#   }
# }

################################################################################
################################################################################

# Stack Overflow Reply

# {
#   provider: "stackexchange",
#   uid: 925848,
#   info: {
#     nickname: "ncronquist",
#     image: "https://www.gravatar.com/avatar/dcc1de21ce06e8c03ba373c95b4b0590?s=128&d=identicon&r=PG",
#     urls: {
#       stackoverflow: "http://stackoverflow.com/users/925848/ncronquist"
#       },
#       name: "ncronquist"
#       },
#       credentials: {
#         token: "Ei*StANXFGUIz2wsIRx0Jg))",
# expires_at: 1433183216,
# expires: true
# },
# extra: {
#   raw_info: {
#     badge_counts: {
#       bronze: 2,
#       silver: 0,
#       gold: 0
#       },
#       account_id: 886531,
#       is_employee: false,
#       last_modified_date: 1433095253,
#       last_access_date: 1433094989,
#       age: 28,
#       reputation_change_year: 10,
#       reputation_change_quarter: 0,
#       reputation_change_month: 0,
#       reputation_change_week: 0,
#       reputation_change_day: 0,
#       reputation: 11,
#       creation_date: 1314989356,
#       user_type: "registered",
#       user_id: 925848,
#       location: "Seattle, WA",
#       website_url: "http://ncronquist.com",
#       link: "http://stackoverflow.com/users/925848/ncronquist",
#       profile_image: "https://www.gravatar.com/avatar/dcc1de21ce06e8c03ba373c95b4b0590?s=128&d=identicon&r=PG",
#       display_name: "ncronquist"
#     }
#   }
# }

################################################################################
################################################################################


