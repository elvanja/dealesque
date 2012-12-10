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

  def provider
    return @provider if @provider

    @provider = Vacuum.new
    @provider.configure @amazon_credentials
    @provider
  end

  def parse_search_response(xml)
    results = SearchResult.new.extend(SearchResultRepresenter)
    # TODO remove namespace fix after representable resolves pull request #26
    #results.from_xml(xml)
    results.from_xml(Nokogiri::XML(xml).remove_namespaces!.to_s)
  end
end