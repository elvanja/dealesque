require 'spec_helper_without_rails'

describe SearchResultRepresenter do
  context "when representing" do
    let(:search_result) { SearchResult.new(items: []) }

    context "to XML" do
      it "works" do
        expect(search_result.extend(subject).to_xml).to match(/<SearchResult>.*<\/SearchResult>/m)
      end
    end
  end

  context "when consuming" do
    let(:search_result) { SearchResult.new }

    context "from JSON" do
      # TODO resolve xml and json conflict
      let(:json_items_data) { {items: [{},{}]}.to_json }

      it "returns exact number of items" do
        pending "using xml and json in representer breaks it: undefined method `has_key?' for nil:NilClass"
        expect(search_result.extend(subject).from_json(json_items_data).items.size).to eq(2)
      end

      it "creates item as Item" do
        pending "using xml and json in representer breaks it: undefined method `has_key?' for nil:NilClass"
        search_result.from_json(json_items_data).items.each do |item|
          expect(item.class).to be(Item)
        end
      end
    end

    context "from XML" do
      context "with test xml data" do
        let(:xml) { "<SearchResult><Items><Item/><Item/></Items></SearchResult>" }

        it "returns exact number of items" do
          expect(search_result.extend(subject).from_xml(xml).items.size).to eq(2)
        end

        it "creates items as Item" do
          search_result.extend(subject).from_xml(xml).items.each do |item|
            expect(item).to be_a(Item)
          end
        end
      end

      context "with test xml data" do
        let(:amazon_response) { File.read("./doc/resources/amazon_search_response.xml") }

        it "sets amazon search result" do
          expect(search_result.extend(subject).from_xml(amazon_response).items.size).to eq(9)
        end
      end
    end
  end
end