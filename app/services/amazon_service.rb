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
      'ResponseGroup' => 'ItemAttributes,Offers',
      'Keywords' => keywords
    }

    parse_search_response(provider.get(query: params).body)
  end

  def provider(provider = Vacuum)
    return @provider if @provider

    @provider = provider.new
    @provider.configure @amazon_credentials
    @provider
  end

  def parse_search_response(xml)
    results = SearchResult.new.extend(SearchResultRepresenter)
    results.from_xml(xml)
  end
end