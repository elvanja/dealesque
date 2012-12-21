require 'spec_helper_without_rails'

describe AmazonService do
  let(:provider) { stub }
  let(:parser) { stub }
  let(:subject) { AmazonService.new(provider, parser) }

  context "when searching" do
    context "in general" do
      it "delegates search to provider" do
        provider.stub(:get)
        parser.stub(:parse)
        provider.should_receive(:get)
        subject.search(stub)
      end

      it "delegates response parsing to parser" do
        provider.stub(:get)
        parser.should_receive(:parse)
        subject.search(stub)
      end

      it "returns search results" do
        provider.stub(:get)
        parser.stub(:parse).and_return(SearchResult.new)
        expect(subject.search(stub)).to be_a_kind_of(SearchResult)
      end
    end

    context "with keywords" do
      let(:params) {{
          'Operation' => 'ItemSearch',
          'SearchIndex' => 'All',
          'ResponseGroup' => 'ItemAttributes,Offers,Images',
          'Keywords' => 'Odysseus'
      }}

      it "propagates keywords to provider" do
        subject.should_receive(:search).with(params)
        subject.search_with_keywords('Odysseus')
      end
    end
  end

  context "when creating cart" do
    it "invokes cart creating on provider" do
      provider.stub(:get)
      provider.should_receive(:get)
      subject.create_cart_with(stub)
    end
  end

  context "when initializing" do
    it "requires provider" do
      expect { AmazonService.new(nil, stub) }.to raise_error(ArgumentError)
    end

    it "requires response parser" do
      expect { AmazonService.new(stub, nil) }.to raise_error(ArgumentError)
    end
  end
end