require 'spec_helper_without_rails'

describe PickItem do
  context "when picking" do
    let(:item) { Item.new }
    let(:picked_items_container) { PickedItems.new }
    let(:item_offer_listing_scraper) { stub(ItemOfferListingScraper) }
    let(:subject) { PickItem.new(picked_items_container, item_offer_listing_scraper) }

    it "stores item into picked item container" do
      item_offer_listing_scraper.should_receive(:scrape_offers_for).and_return([])
      subject.pick(item)
      expect(picked_items_container.include?(item)).to eq(true)
    end

    it "scrapes additional item offers" do
      item_offer_listing_scraper.should_receive(:scrape_offers_for).with(item).and_return(Array.new(10) {|index| stub(Offer).as_null_object})
      subject.pick(item)
      expect(item.offers.size).to eq(10)
    end
  end

  context "when initializing" do
    it "requires picked items container" do
      expect { PickItem.new(nil) }.to raise_error(ArgumentError)
    end

    it "requires add scraped item offers to item if defined" do
      expect { PickItem.new(stub, nil) }.to raise_error
    end
  end
end