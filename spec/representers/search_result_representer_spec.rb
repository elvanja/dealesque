require 'spec_helper_without_rails'

describe SearchResultRepresenter do
  context "when decoding items" do
    let(:search_result) { SearchResult.new.extend(subject) }

    context "from json" do
      # TODO resolve xml and json conflict
      let(:json_items_data) { {items: [{},{}]}.to_json }

      it "returns exact number of items" do
        pending "using xml and json in representer breaks it: undefined method `has_key?' for nil:NilClass"
        expect(search_result.from_json(json_items_data).items.size).to eq(2)
      end

      it "decodes items as Item" do
        pending "using xml and json in representer breaks it: undefined method `has_key?' for nil:NilClass"
        search_result.from_json(json_items_data).items.each do |item|
          expect(item.class).to be(Item)
        end
      end
    end

    context "from xml" do
      context "with test xml data" do
        let(:xml_items_data) { "<SearchResult><Items><Item/><Item/></Items></SearchResult>" }

        it "returns exact number of items" do
          expect(search_result.from_xml(xml_items_data).items.size).to eq(2)
        end

        it "decodes items as Item" do
          search_result.from_xml(xml_items_data).items.each do |item|
            expect(item).to be_a(Item)
          end
        end
      end

      context "with test xml data" do
        let(:amazon_response) { File.read("./doc/resources/amazon_search_response.xml") }

        it "decodes amazon search result" do
          expect(search_result.from_xml(amazon_response).items.size).to eq(9)
        end
      end
    end
  end
end