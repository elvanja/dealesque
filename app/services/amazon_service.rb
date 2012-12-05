require 'vacuum'

class AmazonService
  def initialize(amazon_credentials)
    raise ArgumentError unless amazon_credentials
    @amazon_credentials = amazon_credentials
  end

  # TODO: parse response into value objects
  def search_with_keywords(keywords)
    params = {
      'Operation' => 'ItemSearch',
      'SearchIndex' => 'All',
      'Keywords' => keywords
    }
    provider.get(query: params)
  end

  def provider
    return @provider if @provider

    @provider = Vacuum.new
    @provider.configure @amazon_credentials
    @provider
  end
end