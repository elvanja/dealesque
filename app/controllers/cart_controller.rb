class CartController < ApplicationController
  before_filter :retrieve_picked_items_from_session

  def create
    create_cart = CreateAmazonCart.new(AmazonClient.new(AMAZON_CREDENTIALS))
    cart = create_cart.with_picked_items(@picked_items)
    redirect_to cart.purchase_url
  end

  private

  def retrieve_picked_items_from_session
    @picked_items = PickedItems.new.extend(PickedItemsRepresenter)
    @picked_items.from_json(session[:picked_items]) if session[:picked_items]
  end
end
