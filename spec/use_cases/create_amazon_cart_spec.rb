require 'spec_helper_without_rails'

describe CreateAmazonCart do
  context "when searching by keywords" do
    let(:amazon_client) { AmazonClient.new(stub.as_null_object) }
    let(:subject) { CreateAmazonCart.new(amazon_client) }
    let(:picked_items) { stub }

    it "delegates to amazon service" do
      amazon_client.should_receive(:create_cart_with).with(picked_items)
      subject.with_picked_items(picked_items)
    end
  end

  context "when initializing" do
    it "requires amazon service" do
      expect { SearchAmazon.new(nil) }.to raise_error(ArgumentError)
    end
  end
end