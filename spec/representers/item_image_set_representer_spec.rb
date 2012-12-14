require 'spec_helper_without_rails'

describe ItemImageSetRepresenter do
  context "when representing" do
    let (:image_set) { ItemImageSet.new(category: "primary", tiny: ItemImage.new) }

    context "to XML" do
      it "works" do
        puts image_set.extend(subject).to_xml
        expect(image_set.extend(subject).to_xml).to match(/<ImageSet Category="primary">.*<\/ImageSet>/m)
      end
    end
  end

  context "when consuming" do
    context "from XML" do
      let (:xml) {"""
        <ImageSet Category=\"primary\">
            <SwatchImage/>
            <SmallImage/>
            <ThumbnailImage/>
            <TinyImage/>
            <MediumImage/>
            <LargeImage/>
        </ImageSet>
      """}

      it "sets category" do
        image_set = ItemImageSet.new.extend(ItemImageSetRepresenter).from_xml(xml)
        expect(image_set.category).to eq("primary")
      end

      [:tiny, :small, :medium, :large, :swatch, :thumbnail].each do |image_type|
        it "sets #{image_type} image" do
          image_set = ItemImageSet.new.extend(ItemImageSetRepresenter).from_xml(xml)
          expect(image_set.send(image_type)).not_to eq(nil)
          expect(image_set.send(image_type)).to be_a_kind_of(ItemImage)
        end
      end
    end
  end
end