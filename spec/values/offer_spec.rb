require 'spec_helper_without_rails'

describe Offer do
  context "with attributes" do
    %w{id price merchant condition item}.each do |property|
      it "has #{property}" do
        expect(subject).to respond_to(property)
        expect(subject).to respond_to("#{property}=")
      end
    end
  end

  context "when initializing" do
    context "without supplied attributes" do
      it "requires attribute hash" do
        expect { Offer.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with supplied attributes" do
      let(:attributes) { {id: 1, price: Price.new, merchant: "Amazon", condition: Condition::NEW, item: Item.new} }
      let(:subject) { Offer.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.public_send(attribute)).to eq(value)
        end
      end
    end
  end
end