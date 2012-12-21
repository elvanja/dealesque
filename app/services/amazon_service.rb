class AmazonService
  def initialize(provider)
    raise ArgumentError unless provider
    @provider = provider
  end

  def create_cart_with(picked_items)
    params = {'Operation' => 'CartCreate'}
    picked_items.each_with_index do |item, index|
      params["Item.#{index}.ASIN"] = item.id.to_s
      params["Item.#{index}.Quantity"] = 1.to_s
    end
    AmazonCartResponseParser.new.parse(call(params))
  end

  def search_with_keywords(keywords)
    AmazonSearchResponseParser.new.parse (
      call  'Operation' => 'ItemSearch',
            'SearchIndex' => 'All',
            'ResponseGroup' => 'ItemAttributes,Offers,Images',
            'Keywords' => keywords
    )
  end

  private

  def call(params)
    @provider.get(query: params)
  end
end