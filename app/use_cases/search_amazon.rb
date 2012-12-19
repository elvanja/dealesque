class SearchAmazon
  def initialize(amazon_service)
    raise ArgumentError unless amazon_service
    @amazon_service = amazon_service
  end

  def with_keywords(keywords)
    @amazon_service.search_with_keywords(keywords)
  end
end