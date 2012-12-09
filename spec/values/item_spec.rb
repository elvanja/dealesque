require 'spec_helper_without_rails'

describe Item do
  context "with attributes" do
    it "has a title" do
      expect(subject).to respond_to(:title)
      expect(subject).to respond_to(:title=)
    end

    it "has a description" do
      expect(subject).to respond_to(:description)
      expect(subject).to respond_to(:description=)
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
      let(:attributes) { {title: "Shoulda coulda woulda", description: "The best book in the world"} }
      let(:subject) { Item.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.send(attribute)).to eq(value)
        end
      end
    end
  end
end