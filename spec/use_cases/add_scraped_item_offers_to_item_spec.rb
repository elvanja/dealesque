require 'spec_helper_without_rails'

class MockItemWithAppendingOffers
  Surrogate.endow self
  define_reader(:offers)
  define(:append_offers) { |offers| @offers += offers }
  def initialize
    @offers = []
  end
end

describe MockItemWithAppendingOffers do
  it "is a subset of Item" do
    expect(Item).to substitute_for(MockItemWithAppendingOffers, subset: true)
  end
end

class MockItemOfferListingScraper
  Surrogate.endow self
  define(:scrape_offers_for) { |item| }
end

describe MockItemOfferListingScraper do
  it "is a subset of ItemOfferListingScraper" do
    expect(ItemOfferListingScraper).to substitute_for(MockItemOfferListingScraper, subset: true)
  end
end

describe AddScrapedItemOffersToItem do
  context "when scraping for an item" do
    let(:item) { MockItemWithAppendingOffers.new }
    let(:scraper) { stub(ItemOfferListingScraper) }
    let(:subject) { AddScrapedItemOffersToItem.new(scraper) }

    it "appends scraped offers to the item" do
      scraper.should_receive(:scrape_offers_for).with(item).and_return(Array.new(10) {|index| stub(Offer)})
      subject.for(item)
      expect(item.offers.size).to eq(10)
    end
  end

  context "when initializing" do
    it "requires item offer listing scraper" do
      expect { AddScrapedItemOffersToItem.new(nil) }.to raise_error(ArgumentError)
    end
  end
end