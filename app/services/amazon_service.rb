class AmazonService
  def initialize(provider, parser = AmazonResponseParser.new)
    raise ArgumentError unless provider && parser

    @provider = provider
    @parser = parser
  end

  def create_cart_with(picked_items)
    search 'Operation' => 'ItemSearch',
           'SearchIndex' => 'All',
           'ResponseGroup' => 'ItemAttributes,Offers,Images',
           'Keywords' => keywords
  end

  def search_with_keywords(keywords)
    search 'Operation' => 'ItemSearch',
           'SearchIndex' => 'All',
           'ResponseGroup' => 'ItemAttributes,Offers,Images',
           'Keywords' => keywords
  end

  def search(params)
    @parser.parse(call(params))
  end

  private

  def call(params)
    @provider.get(query: params)
  end
end