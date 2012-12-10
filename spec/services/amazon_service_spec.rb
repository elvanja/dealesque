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

      it "is valid search" do
        pending "check for 'isvalid' return value, in case api changes"
      end

      it "constructs search result from response" do
        subject.provider.stub(:get) { amazon_response }
        expect(subject.search_with_keywords("Practical Object-Oriented Design in Ruby")).to be_a(SearchResult)
      end
    end

    context "when parsing search response" do
      let(:amazon_response) { OpenStruct.new(
          body: File.read("./doc/resources/amazon_search_response.xml").gsub(/<ItemSearchResponse>/, '<ItemSearchResponse xmlns="exists">')
      )}

      # TODO remove namespace fix after representable resolves pull request #26
      it "removes namespace" do
        subject.provider.stub(:get) { amazon_response }
        expect(subject.search_with_keywords("Practical Object-Oriented Design in Ruby")).to be_a(SearchResult)
      end
    end
  end

  context "when initializing" do
    it "requires amazon credentials" do
      expect { AmazonService.new(nil) }.to raise_error(ArgumentError)
    end
  end
end