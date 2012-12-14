require 'spec_helper_without_rails'

describe ItemRepresenter do
  context "when representing" do
    let (:item) { Item.new(id: "A123456", title: "Practical Object-Oriented Design in Ruby") }

    context "to XML" do
      it "works" do
        expect(item.extend(subject).to_xml).to match(/<Item>.*<\/Item>/m)
      end
    end
  end

  context "when consuming" do
    context "from JSON" do
      it "should decode from JSON" do
        # TODO resolve xml and json conflict
        pending "using xml and json in representer breaks it: undefined method `has_key?' for nil:NilClass"
      end
    end

    context "from XML" do
      let (:xml) {"""
        <Item>
          <ASIN>0321721330</ASIN>
          <DetailPageURL>http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley</DetailPageURL>
          <ItemAttributes>
              <Author>Sandi Metz</Author>
              <Manufacturer>Addison-Wesley Professional</Manufacturer>
              <ProductGroup>Book</ProductGroup>
              <Title>Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)</Title>
          </ItemAttributes>
          <ImageSets>
              <ImageSet Category=\"primary\"/>
              <ImageSet Category=\"secondary\"/>
          </ImageSets>
        </Item>
      """}

      it "sets id" do
        item = Item.new.extend(subject).from_xml(xml)
        expect(item.id).to eq("0321721330")
      end

      it "sets title" do
        item = Item.new.extend(subject).from_xml(xml)
        expect(item.title).to eq("Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)")
      end

      it "sets url" do
        item = Item.new.extend(subject).from_xml(xml)
        expect(item.url).to eq("http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley")
      end

      it "sets group" do
        item = Item.new.extend(subject).from_xml(xml)
        expect(item.group).to eq("Book")
      end

      it "decodes image sets" do
        item = Item.new.extend(subject).from_xml(xml)
        expect(item.image_sets.size).to eq(2)
      end
    end
  end
end