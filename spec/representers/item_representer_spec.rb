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

  it "should decode from XML" do
    expect(Item.new.extend(ItemRepresenter).from_xml("<item><title>one</title></item>").title).to eq("one")
  end
end