require 'spec_helper_without_rails'

describe Price do
  context "with attributes" do
    %w{amount currency formatted}.each do |property|
      it "has #{property}" do
        expect(subject).to respond_to(property)
        expect(subject).to respond_to("#{property}=")
      end
    end
  end

  context "price not available constant" do
    let(:not_available) { Price::NOT_AVAILABLE }

    it "has specific defaults" do
      expect(not_available.amount).to eq(0)
      expect(not_available.currency).to eq("N/A")
      expect(not_available.formatted).to eq("N/A")
    end
  end

  context "when initializing" do
    context "without supplied attributes" do
      it "requires attribute hash" do
        expect { Price.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with supplied attributes" do
      let(:attributes) { {amount: 1, currency: 'USD', formatted: '$27.81'} }
      let(:subject) { Price.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.public_send(attribute)).to eq(value)
        end
      end
    end
  end
end