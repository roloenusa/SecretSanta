# Load the rails application
require File.expand_path('../application', __FILE__)

config.action_mailer.default_url_options = { :host => “papanoel.heroku.com” }

# Initialize the rails application
SecretSanta::Application.initialize!
