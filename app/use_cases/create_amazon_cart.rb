class CreateAmazonCart
  def initialize(amazon_service)
    raise ArgumentError unless amazon_service
    @amazon_service = amazon_service
  end

  def with_picked_items(picked_items)
    @amazon_service.create_cart_with(picked_items)
  end
end