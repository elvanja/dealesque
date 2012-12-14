require 'spec_helper_without_rails'

describe PickedItemsRepresenter do
  context "when representing" do
    let(:picked_items) do
      PickedItems.new.extend(subject).tap do |p|
        p.add Item.new
        p.add Item.new
      end
    end

    context "to JSON" do
      # TODO resolve xml and json conflict
    end

    context "to XML" do
      it "represents" do
        expect(picked_items.to_xml).to match(/<PickedItems>.*<\/PickedItems>/m)
      end
    end
  end

  context "when consuming" do
    let(:picked_items) { PickedItems.new.extend(subject) }

    context "from JSON" do
      # TODO resolve xml and json conflict
    end

    context "from XML" do
      let(:xml) { "<PickedItems><Item/><Item/></PickedItems>" }

      it "returns exact number of items" do
        expect(picked_items.from_xml(xml).size).to eq(2)
      end

      it "decodes items as Item" do
        picked_items.from_xml(xml).each do |item|
          expect(item).to be_a(Item)
        end
      end
    end
  end
end