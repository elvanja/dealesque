require "spec_helper"
require 'vacuum'

describe "create amazon cart golden path" do
  let(:credentials) { YAML::load(File.open("config/amazon.yml"))["test"] }
  let(:provider) { Vacuum.new.tap { |provider| provider.configure(credentials) } }

  it "adds the items to cart" do
    service = AmazonService.new(provider)
    create_cart = CreateAmazonCart.new(service)
    picked_items = PickedItems.new
    picked_items.add(Item.new(id: '0321721330'))
    picked_items.add(Item.new(id: 'B008VHMWMI'))
    cart = create_cart.with_picked_items(picked_items)
    expect(cart).to be_a(Cart)
    expect(cart.purchase_url).to match(/https:\/\/www.amazon.com\/gp\/cart\/.*associate-id=#{credentials["tag"]}.*/)
  end
end