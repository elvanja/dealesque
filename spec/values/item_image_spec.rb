require 'spec_helper_without_rails'

describe ItemImage do
  context "with attributes" do
    %w{url height width type}.each do |property|
      it "has #{property}" do
        expect(subject).to respond_to(property.to_sym)
        expect(subject).to respond_to("#{property}=".to_sym)
      end
    end
  end

  # TODO extract behaviour and specs into a module
  context "when initializing" do
    context "without supplied attributes" do
      it "requires attribute hash" do
        expect { ItemImage.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with supplied attributes" do
      let(:attributes) { {url: "http://some.url", height: 100, width: 100, type: :thumbnail} }
      let(:subject) { ItemImage.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.send(attribute)).to eq(value)
        end
      end
    end
  end
end