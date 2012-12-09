require 'spec_helper_without_rails'

describe SearchResult do
  context "with attributes" do
    it "has items" do
      expect(subject).to respond_to(:items)
      expect(subject).to respond_to(:items=)
    end
  end

  # TODO extract behaviour and specs into a module
  context "when initializing" do
    context "without supplied attributes" do
      it "requires attribute hash" do
        expect { SearchResult.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with supplied attributes" do
      let(:attributes) { {items: []} }
      let(:subject) { SearchResult.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.send(attribute)).to eq(value)
        end
      end
    end
  end
end