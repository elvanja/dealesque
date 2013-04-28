require 'spec_helper_without_rails'

describe PriceRepresenter do
  context "when representing" do
    let(:price) { Price.new(fractional: 1023, currency: :usd) }

    context "to JSON" do
      it "represents properties" do
        names = %({"fractional":1023,"currency":"USD"})
        expect(price.extend(subject).to_json).to be_json_eql(names)
      end
    end
  end

  context "when consuming" do
    context "from JSON" do
      let(:json) { %({"fractional":1023,"currency":"USD"}) }

      it "consumes properties" do
        offer = Price.new.extend(subject).from_json(json)
        expect(offer.fractional).to eq(1023)
        expect(offer.currency_as_string).to eq("USD")
      end
    end
  end
end