require 'spec_helper_without_rails'

describe Item do
  context "with attributes" do
    %w{id title url group image_sets}.each do |property|
      it "has #{property}" do
        expect(subject).to respond_to(property.to_sym)
        expect(subject).to respond_to("#{property}=".to_sym)
      end
    end
  end

  context "with image sets" do
    context "when not defined" do
      it "defaults to empty array" do
        expect(subject.image_sets).to eq([])
      end
    end

    context "when passing in the image sets" do
      let(:primary) { ItemImageSet.new(category: "primary") }
      let(:secondary) { ItemImageSet.new(category: "secondary") }
      let(:image_sets) { [primary, secondary] }
      let(:subject) { Item.new(image_sets: image_sets) }

      it "gets image set by category" do
        expect(subject.image_set(:primary)).to eq(primary)
        expect(subject.image_set(:not_exists)).to eq(nil)
      end
    end
  end

  # TODO extract behaviour and specs into a module
  context "when initializing" do
    context "without supplied attributes" do
      it "requires attribute hash" do
        expect { Item.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with supplied attributes" do
      let(:attributes) { {id: 1, title: "Shoulda coulda woulda", url: "http://some.url", group: "book"} }
      let(:subject) { Item.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.send(attribute)).to eq(value)
        end
      end
    end
  end
end