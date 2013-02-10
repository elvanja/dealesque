require 'spec_helper_without_rails'

describe PriceRepresenter do
  context "when representing" do
    let(:offer) { Price.new(amount: 10.23, currency: "USD", formatted: "$10.23") }

    context "to JSON" do
      it "represents properties" do
        names = %({"amount":10.23,"currency":"USD","formatted":"$10.23"})
        expect(offer.extend(subject).to_json).to be_json_eql(names)
      end
    end
  end

  context "when consuming" do
    context "from JSON" do
      let(:json) { %({"amount":10.23,"currency":"USD","formatted":"$10.23"}) }

      it "consumes properties" do
        offer = Price.new.extend(subject).from_json(json)
        expect(offer.amount).to eq(10.23)
        expect(offer.currency).to eq("USD")
        expect(offer.formatted).to eq("$10.23")
      end
    end
  end
end