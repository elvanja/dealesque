require "spec_helper"

describe "search by keywords golden path" do
  let(:amazon_credentials) { YAML::load(File.open("config/amazon.yml"))["test"] }

  it "returns the desired items" do
    service = AmazonService.new(amazon_credentials)
    search = SearchAmazon.new(service)
    result = search.with_keywords("Practical Object-Oriented Design in Ruby")
    expect(result).to be_a(SearchResult)
    expect(result.items.first.title).to eq("Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)")
  end
end