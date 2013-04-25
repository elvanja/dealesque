require 'spec_helper_without_rails'

class MockItemWithMoreOffersUrl
  Surrogate.endow self
  define(:initialize) { |args| @more_offers_url = args[:more_offers_url] }
  define_reader(:more_offers_url)
end

describe MockItemWithMoreOffersUrl do
  it "is a subset of Item" do
    expect(Item).to substitute_for(MockItemWithMoreOffersUrl, subset: true)
  end
end

describe ItemOfferListingScraper do
  context "when scraping for item offers" do
    let(:item) { MockItemWithMoreOffersUrl.new(more_offers_url: "http://www.amazon.com/gp/offer-listing/0321584104%3FSubscriptionId%3DAKIAIAPIAMDJ5EGZIPJQ%26tag%3Ddealesque-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3D0321584104") }

    it "scrapes offers" do
      VCR.use_cassette("scrap_all_item_offers") do
        expect(subject.scrape_offers_for(item).size).to eq(15)
      end
    end
  end

  context "when initializing" do
  end
end