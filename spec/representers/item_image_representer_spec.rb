require 'spec_helper_without_rails'

describe ItemImageRepresenter do
  context "when representing" do
    let (:item_image) { ItemImage.new(url: "some url", height: 100, width: 50, type: "small") }

    context "to XML" do
      it "works" do
        expect(item_image.extend(subject).to_xml).to match(/<ItemImage>.*<\/ItemImage>/m)
      end
    end
  end

  context "when consuming" do
    context "from XML" do
      let (:xml) {"""
        <Image>
            <URL>http://ecx.images-amazon.com/images/I/41IDuwJXFCL._SL75_.jpg</URL>
            <Height Units=\"pixels\">75</Height>
            <Width Units=\"pixels\">57</Width>
        </Image>
      """}

      it "works" do
        item_image = ItemImage.new.extend(subject).from_xml(xml)
        expect(item_image.url).to eq("http://ecx.images-amazon.com/images/I/41IDuwJXFCL._SL75_.jpg")
        expect(item_image.height).to eq(75)
        expect(item_image.width).to eq(57)
      end
    end
  end
end