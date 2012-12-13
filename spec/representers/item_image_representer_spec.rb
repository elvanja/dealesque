require 'spec_helper_without_rails'

describe ItemImageRepresenter do
  let (:xml) {
    """
    <Image>
        <URL>http://ecx.images-amazon.com/images/I/41IDuwJXFCL._SL75_.jpg</URL>
        <Height Units=\"pixels\">75</Height>
        <Width Units=\"pixels\">57</Width>
    </Image>
    """
  }

  it "should decode from XML" do
    image = ItemImage.new.extend(ItemImageRepresenter).from_xml(xml)
    expect(image.url).to eq("http://ecx.images-amazon.com/images/I/41IDuwJXFCL._SL75_.jpg")
    expect(image.height).to eq(75)
    expect(image.width).to eq(57)
  end
end