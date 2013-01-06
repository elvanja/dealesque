require 'spec_helper_without_rails'
require 'vacuum'

describe "search by keywords golden path" do
  let(:credentials) { YAML::load(File.open("config/amazon.yml"))["test"] }
  let(:provider) { Vacuum.new.tap { |provider| provider.configure(credentials) } }

  let(:search_matcher) {
    lambda do |new_request, saved_request|
      new_keywords = new_request.uri[/Keywords=(.*)Operation=.*/, 1]
      saved_keywords = saved_request.uri[/Keywords=(.*)Operation=.*/, 1]
      new_keywords == saved_keywords
    end
  }

  it "returns the desired items" do
    service = AmazonService.new(provider)
    search = SearchAmazon.new(service)
    VCR.use_cassette("search_by_keywords_returns_the_desired_items", match_requests_on: [:method, search_matcher]) do
      result = search.with_keywords("Practical Object-Oriented Design in Ruby")
      expect(result).to be_a(SearchResult)
      expect(result.items.first.title).to eq("Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)")
    end
  end
end