require 'spec_helper_without_rails'

describe Item do
  context "with attributes" do
    %w{id title url group}.each do |property|
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