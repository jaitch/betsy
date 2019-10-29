require "dotenv"

Rails.application.config.middleware.use OmniAuth::Builder do
  Dotenv.load
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email"
end