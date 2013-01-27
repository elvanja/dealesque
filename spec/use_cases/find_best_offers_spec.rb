require 'spec_helper_without_rails'

class MockItemWithOffers
  Surrogate.endow self
  define(:initialize) { |args| @offers = args[:offers] }
  define_reader(:offers)
end

describe MockItemWithOffers do
  it "is a subset of Item" do
    expect(Item).to substitute_for(MockItemWithOffers, subset: true)
  end
end

class MockOfferWithPrice
  Surrogate.endow self
  define(:initialize) { |args| @price = args[:price] }
  define_reader(:price)
end

describe MockOfferWithPrice do
  it "is a subset of Offer" do
    expect(Offer).to substitute_for(MockOfferWithPrice, subset: true)
  end
end

describe FindBestOffers do
  context "when searching for best offers" do
    context "with a single picked item" do
      let(:item) {
        MockItemWithOffers.new(offers: [
            MockOfferWithPrice.new(price: 50),
            MockOfferWithPrice.new(price: 20),
            MockOfferWithPrice.new(price: 30)
        ])
      }

      let(:picked_items) {
        PickedItems.new.tap do |picked_items|
          picked_items.add(item)
        end
      }

      it "returns only one best offer" do
        best_offers = subject.for_picked_items(picked_items)
        expect(best_offers.size).to eq(1)
      end

      it "returns minimum offer for the item" do
        best_offer = subject.for_picked_items(picked_items).first
        expect(best_offer.price).to eq(20)
      end
    end

    context "with no picked items" do
      it "requires picked items" do
        expect { subject.for_picked_items(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with empty picked items" do
      it "returns empty offers" do
        expect(subject.for_picked_items([])).to eq([])
      end
    end
  end
end