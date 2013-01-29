require 'spec_helper_without_rails'

describe OfferRepresenter do
  context "when representing" do
    let(:offer) { Offer.new(price: 10.23, currency: "USD", formatted_price: "$10.23", merchant: 'Amazon', condition: Condition::USED) }

    context "to JSON" do
      it "represents properties" do
        names = %({"price":10.23,"currency":"USD","formatted_price":"$10.23","merchant":"Amazon","condition":"used"})
        expect(offer.extend(subject).to_json).to be_json_eql(names)
      end
    end
  end

  context "when consuming" do
    context "from JSON" do
      let(:json) { %({"price":10.23,"currency":"USD","formatted_price":"$10.23","merchant":"Amazon","condition":"used"}) }

      it "consumes properties" do
        offer = Offer.new.extend(subject).from_json(json)
        expect(offer.price).to eq(10.23)
        expect(offer.currency).to eq("USD")
        expect(offer.formatted_price).to eq("$10.23")
        expect(offer.merchant).to eq("Amazon")
        expect(offer.condition).to eq("used")
      end
    end
  end
end