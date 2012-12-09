require 'spec_helper_without_rails'
require 'yaml'

describe AmazonService do
  # TODO: use hash with indifferent access so reading credentials from yaml can use symbols
  # http://stackoverflow.com/questions/7072986/rails-load-yaml-to-hash-and-reference-by-symbol
  # TODO: record amazon responses and reuse in tests (no need to call amazon all the time)

  let(:amazon_credentials) { YAML::load(File.open("config/amazon.yml"))["test"] }
  let(:subject) { AmazonService.new(amazon_credentials) }

  context "when searching" do
    context "with keywords" do
      let(:amazon_response) { OpenStruct.new(body: File.read("./doc/resources/amazon_search_response.xml")) }
      let(:provider) { TestProvider = OpenStruct.new }

      it "is valid search" do
        pending "check for 'isvalid' return value, in case api changes"
      end

      it "constructs search result from response" do
        provider.should_receive(:get).and_return(amazon_response)
        subject.should_receive(:provider).and_return(provider)
        expect(subject.search_with_keywords("Practical Object-Oriented Design in Ruby")).to be_a(SearchResult)
      end

      it "with name of a known book" do
        pending "should return the book in results" # TODO to I need to test this at all?
      end
    end
  end

  context "when initializing" do
    it "requires amazon credentials" do
      expect { AmazonService.new(nil) }.to raise_error(ArgumentError)
    end
  end
end