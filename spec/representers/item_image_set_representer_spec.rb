require 'spec_helper_without_rails'

describe ItemImageSetRepresenter do
  let (:xml) {
    """
    <ImageSet Category=\"primary\">
        <SwatchImage/>
        <SmallImage/>
        <ThumbnailImage/>
        <TinyImage/>
        <MediumImage/>
        <LargeImage/>
    </ImageSet>
    """
  }

  context "when decoding from XML" do
    let(:image_set) { ItemImageSet.new.extend(ItemImageSetRepresenter).from_xml(xml) }

    it "decodes category" do
      expect(image_set.category).to eq("primary")
    end

    [:tiny, :small, :medium, :large, :swatch, :thumbnail].each do |image_type|
      it "decodes #{image_type} image" do
        expect(image_set.send(image_type)).not_to eq(nil)
        expect(image_set.send(image_type)).to be_a_kind_of(ItemImage)
      end
    end
  end
end