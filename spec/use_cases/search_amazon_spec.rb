require 'spec_helper_without_rails'

describe SearchAmazon do
  context "when searching by keywords" do
    #let(:amazon_service) {AmazonService.new()}
    #let(:subject) {SearchAmazon.new(amazon_service)}

    it "with name of a known book" do

      puts subject.with_keywords("Practical Object-Oriented Design in Ruby")
    end
  end

  context "when initializing" do
    it "expects amazon service" do
      expect { SearchAmazon.new(nil) }.to raise_error(ArgumentError)
    end
  end
end