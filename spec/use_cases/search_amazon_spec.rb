require 'spec_helper_without_rails'

describe SearchAmazon do
  context "when searching by keywords" do
    let(:amazon_service) { AmazonService.new(stub, stub) }
    let(:subject) { SearchAmazon.new(amazon_service) }

    it "delegates to amazon service" do
      amazon_service.should_receive(:search_with_keywords).with("Ulysses")
      subject.with_keywords("Ulysses")
    end
  end

  context "when initializing" do
    it "requires amazon service" do
      expect { SearchAmazon.new(nil) }.to raise_error(ArgumentError)
    end
  end
end