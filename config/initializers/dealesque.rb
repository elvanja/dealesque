require 'yaml'

# TODO notify if file is missing
AMAZON_CREDENTIALS = YAML::load(File.open("config/amazon.yml"))[Rails.env]
