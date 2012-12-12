require 'yaml'

class ConfigurationError < StandardError; end

credentials_file = "config/amazon.yml"
raise ConfigurationError("Missing credentials file, expected to be at #{File.expand_path(credentials_file)}") unless File.exists?(credentials_file)

AMAZON_CREDENTIALS = YAML::load(File.open(credentials_file))[Rails.env]
