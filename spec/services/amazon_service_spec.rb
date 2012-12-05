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
      it "with name of a known book" do
        puts subject.search_with_keywords("Practical Object-Oriented Design in Ruby").inspect
      end
    end
  end

  context "when initializing" do
    it "requires amazon credentials" do
      expect { AmazonService.new(nil) }.to raise_error(ArgumentError)
    end
  end
end