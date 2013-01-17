class CreateAmazonCart
  def initialize(amazon_client)
    raise ArgumentError.new("Missing Amazon client") unless amazon_client
    @amazon_client = amazon_client
  end

  def with_picked_items(picked_items)
    @amazon_client.create_cart_with(picked_items)
  end
end