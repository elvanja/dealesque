class SearchAmazon
  def initialize(amazon_client)
    raise ArgumentError.new("Missing Amazon client") unless amazon_client
    @amazon_client = amazon_client
  end

  def with_keywords(keywords)
    @amazon_client.search_with_keywords(keywords)
  end
end