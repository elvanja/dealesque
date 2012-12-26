require 'spec_helper_without_rails'

describe AmazonService do
  let(:provider) { stub }
  let(:subject) { AmazonService.new(provider) }

  context "when searching" do
    context "with keywords" do
      let(:params) {{
          'Operation' => 'ItemSearch',
          'SearchIndex' => 'All',
          'ResponseGroup' => 'ItemAttributes,Offers,Images',
          'Keywords' => 'Odysseus'
      }}

      it "propagates keywords to provider" do
        AmazonSearchResponseParser.any_instance.should_receive(:parse)
        provider.should_receive(:get).with({query: params})
        subject.search_with_keywords('Odysseus')
      end
    end
  end

  context "when creating cart" do
    let(:picked_items) { [Item.new(id: 1), Item.new(id: 2)] }
    let(:params) {{
        'Operation' => 'CartCreate',
        'Item.0.ASIN' => '1',
        'Item.0.Quantity' => '1',
        'Item.1.ASIN' => '2',
        'Item.1.Quantity' => '1'
    }}

    it "invokes cart creating on provider" do
      AmazonCartResponseParser.any_instance.should_receive(:parse)
      provider.should_receive(:get).with({query: params})
      subject.create_cart_with(picked_items)
    end
  end

  context "when initializing" do
    it "requires provider" do
      expect { AmazonService.new(nil) }.to raise_error(ArgumentError)
    end
  end
end