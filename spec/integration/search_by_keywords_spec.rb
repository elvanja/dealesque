require "spec_helper"
require 'vacuum'

describe "search by keywords golden path" do
  let(:credentials) { YAML::load(File.open("config/amazon.yml"))["test"] }
  let(:provider) { Vacuum.new.tap { |provider| provider.configure(credentials) } }

  it "returns the desired items" do
    service = AmazonService.new(provider)
    search = SearchAmazon.new(service)
    result = search.with_keywords("Practical Object-Oriented Design in Ruby")
    expect(result).to be_a(SearchResult)
    expect(result.items.first.title).to eq("Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)")
  end
end