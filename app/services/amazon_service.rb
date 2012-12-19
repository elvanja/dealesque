class AmazonService
  def initialize(provider, parser = AmazonResponseParser.new)
    raise ArgumentError unless provider && parser

    @provider = provider
    @parser = parser
  end

  def search_with_keywords(keywords)
    search({
               'Operation' => 'ItemSearch',
               'SearchIndex' => 'All',
               'ResponseGroup' => 'ItemAttributes,Offers,Images',
               'Keywords' => keywords
           })
  end

  def search(params)
    @parser.parse(@provider.get(query: params))
  end
end