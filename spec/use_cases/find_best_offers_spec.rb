require 'spec_helper_without_rails'

describe FindBestOffers do
  context "when searching for best offers" do
    it "requires picked items" do
      expect { subject.for_picked_items(nil) }.to raise_error(ArgumentError)
    end

    context "with empty picked items" do
      it "returns empty offers" do
        expect(subject.for_picked_items([])).to eq([])
      end
    end

    context "with a single picked item" do
      let(:picked_items) {
        PickedItems.new.tap do |picked_items|
          offers = [
              stub("Offer", price: 50),
              stub("Offer", price: 20),
              stub("Offer", price: 30)
          ]
          item = stub("Item", offers: offers)
          picked_items.add(item)
        end
      }

      it "returns minimum offer for the item" do
        best_offers = subject.for_picked_items(picked_items)
        expect(best_offers.size).to eq(1)
        expect(best_offers.first.price).to eq(20)
      end
    end
  end
end