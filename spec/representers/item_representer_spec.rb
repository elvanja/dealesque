require 'spec_helper_without_rails'

describe ItemRepresenter do
  #include JsonRepresenterSpecHelper
  #
  #should_decode_with_json_representer(
  #    {
  #        title: "Coulda, woulda, shoulda",
  #        description: "The best book in the world"
  #    },
  #    ItemRepresenter,
  #    Item
  #)

  it "should decode from JSON" do
    # TODO resolve xml and json conflict
    pending "using xml and json in representer breaks it: undefined method `has_key?' for nil:NilClass"
  end

  let (:item_xml) {
    """
    <Item>
      <ASIN>0321721330</ASIN>
      <DetailPageURL>http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley</DetailPageURL>
      <ItemAttributes>
          <Author>Sandi Metz</Author>
          <Manufacturer>Addison-Wesley Professional</Manufacturer>
          <ProductGroup>Book</ProductGroup>
          <Title>Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)</Title>
      </ItemAttributes>
    </Item>
    """
  }

  it "should decode from XML" do
    item = Item.new.extend(ItemRepresenter).from_xml(item_xml)
    expect(item.id).to eq("0321721330")
    expect(item.title).to eq("Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series)")
    expect(item.url).to eq("http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley")
    expect(item.group).to eq("Book")
  end
end