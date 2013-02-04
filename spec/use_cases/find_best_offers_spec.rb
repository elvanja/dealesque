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
  define(:initialize) { |args|
    @merchant = args[:merchant]
    @price = args[:price]
  }
  define_reader(:merchant)
  define_reader(:price)
end

describe MockOfferWithPrice do
  it "is a subset of Offer" do
    expect(Offer).to substitute_for(MockOfferWithPrice, subset: true)
  end
end

class MockPrice
  Surrogate.endow self
  define(:initialize) { |args| @amount = args[:amount] }
  define_reader(:amount)
end

describe MockPrice do
  it "is a subset of Price" do
    expect(Price).to substitute_for(MockPrice, subset: true)
  end
end

describe FindBestOffers do
  def create_item(offers_data)
    MockItemWithOffers.new(offers: offers_data.collect { |offer_data|
      MockOfferWithPrice.new(merchant: offer_data[:merchant] || 'not important', price: offer_data[:price])
    })
  end

  def item_with_offer_data(offers_data)
    create_item(offers_data.collect { |offer_data|
      {merchant: offer_data[:merchant] || 'not important', price: MockPrice.new(amount: offer_data[:amount])}
    })
  end

  def item_with_offers_amounts(amounts)
    item_with_offer_data(amounts.collect {|amount| {amount: amount}})
  end

  context "when searching for best offers" do
    context "with a single picked item" do
      let(:item) { item_with_offers_amounts([50, 20, 30]) }

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
        expect(best_offer.price.amount).to eq(20)
      end
    end

    context "when taking only prices into account" do
      let(:picked_items) {
        PickedItems.new.tap do |picked_items|
          picked_items.add(item_with_offers_amounts([21, 11, 31]))
          picked_items.add(item_with_offers_amounts([10, 20, 30]))
          picked_items.add(item_with_offers_amounts([22, 32, 12]))
        end
      }

      it "returns minimum offers for all items" do
        best_offers = subject.for_picked_items(picked_items)
        expect(best_offers.collect {|offer| offer.price.amount}).to match_array([10, 11, 12])
      end
    end

    context "when there is a single cheapest merchant for all items" do
      let(:picked_items) {
        PickedItems.new.tap do |picked_items|
          picked_items.add(item_with_offer_data([{merchant: "ebay", amount: 21}, {merchant: "amazon", amount: 11}, {merchant: "target", amount: 31}]))
          picked_items.add(item_with_offer_data([{merchant: "ebay", amount: 10}, {merchant: "amazon", amount: 30}, {merchant: "target", amount: 50}]))
          picked_items.add(item_with_offer_data([{merchant: "ebay", amount: 22}, {merchant: "amazon", amount: 32}, {merchant: "target", amount: 12}]))
        end
      }

      it "returns minimum offers for all items" do
        best_offers = subject.for_picked_items(picked_items)
        expect(best_offers.collect {|offer| offer.merchant}.uniq).to match_array(["ebay"])
        expect(best_offers.collect {|offer| offer.price.amount}).to match_array([21, 10, 22])
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