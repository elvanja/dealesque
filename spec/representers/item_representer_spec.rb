require 'spec_helper_without_rails'

describe ItemRepresenter do
  context "when representing" do
    let(:item) { Item.new(id: "A123456", title: "Ulysses", url: "http://amazon", group: "Books", images: {small: ItemImage.new, large: ItemImage.new}) }

    context "to JSON" do
      it "represents properties" do
        names = %({"id":"A123456","title":"Ulysses","url":"http://amazon","group":"Books"})
        expect(item.extend(subject).to_json).to be_json_eql(names).excluding(:images)
      end

      it "represents images" do
        json_representation = item.extend(subject).to_json
        expect(json_representation).to have_json_path("images")
        expect(json_representation).to have_json_path("images/small")
        expect(json_representation).to have_json_path("images/large")
      end
    end
  end

  context "when consuming" do
    context "from JSON" do
      let(:json) { %({"id":"A123456","title":"Ulysses","url":"http://amazon","group":"Books","images":{"small":{},"large":{}}}) }

      it "consumes properties" do
        item = Item.new.extend(subject).from_json(json)
        expect(item.id).to eq("A123456")
        expect(item.title).to eq("Ulysses")
        expect(item.url).to eq("http://amazon")
        expect(item.group).to eq("Books")
      end

      it "consumes images" do
        item = Item.new.extend(subject).from_json(json)
        expect(item.images.size).to eq(2)
        expect(item.images[:small]).not_to eq(nil)
        expect(item.images[:small]).to be_a_kind_of(ItemImage)
      end
    end
  end
end