require 'spec_helper_without_rails'

describe AmazonSearchResponseParser do
  context "when parsing" do
    let(:response) { OpenStruct.new(body: File.read("./doc/resources/amazon_api_responses/search_response.xml")) }

    it "returns search result" do
      expect(subject.parse(stub.as_null_object)).to be_a_kind_of(SearchResult)
    end

    it "minds not the namespace" do
      response.body = response.body.gsub(/<ItemSearchResponse>/, '<ItemSearchResponse xmlns="exists">')
      expect(subject.parse(response)).to be_a_kind_of(SearchResult)
    end

    context "with search result" do
      it "has search terms" do
        expect(subject.parse(response).search_terms).to eq("Practical Object-Oriented Design in Ruby")
      end

      context "with items" do
        it "has all the items" do
          expect(subject.parse(response).items.size).to eq(9)
        end

        context "with item" do
          let (:item) { subject.parse(response).items.first }

          it "has relevant data" do
            expect(item.id).to eq("0321721330")
            expect(item.title).to eq("Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)")
            expect(item.url).to eq("http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330%3FSubscriptionId%3DAKIAIAPIAMDJ5EGZIPJQ%26tag%3Ddealesque-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0321721330")
            expect(item.group).to eq("Book")
          end

          it "has all the images" do
            expect(item.images.size).to eq(6)
          end

          context "with image" do
            let (:image) { item.images[:swatch] }

            it "has relevant data" do
              expect(image.url).to eq("http://ecx.images-amazon.com/images/I/51vkmxCfmRL._SL30_.jpg")
              expect(image.height).to eq(30)
              expect(image.width).to eq(23)
              expect(image.type).to eq(:swatch)
            end
          end
        end
      end
    end
  end
end