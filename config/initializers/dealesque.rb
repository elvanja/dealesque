require 'yaml'

class ConfigurationError < StandardError; end

def validate_credentials(credentials, environment)
  errors = []
  errors << "Missing amazon key in #{environment}" unless credentials["key"]
  errors << "Missing amazon secret in #{environment}" unless credentials["secret"]
  errors << "Missing amazon tag in #{environment}" unless credentials["tag"]
  errors
end

def get_credentials_from_environment
  credentials = {
      "key" => ENV['AMAZON_KEY'],
      "secret" => ENV['AMAZON_SECERET'],
      "tag" => ENV['AMAZON_TAG']
  }
  return credentials, validate_credentials(credentials, :environment)
end

def get_credentials_from_file
  credentials = {}
  file = 'config/amazon.yml'
  if File.exists?(file)
    credentials = YAML::load(File.open(file))[Rails.env]
    errors = validate_credentials(credentials, file)
  else
    errors = ["Missing credentials file @ #{File.expand_path(file)})"]
  end
  return credentials, errors
end

credentials, errors = get_credentials_from_environment
if errors.size > 0
  credentials, additional_errors = get_credentials_from_file
  raise ConfigurationError.new((errors + additional_errors).join("\n")) if additional_errors.size > 0
end

AMAZON_CREDENTIALS = credentials