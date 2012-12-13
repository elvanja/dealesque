require 'spec_helper_without_rails'

describe PickItem do
  context "when picking" do
    let(:item) { Item.new }
    let(:picked_items_container) { PickedItems.new }
    let(:subject) { PickItem.new(picked_items_container) }

    it "stores item into picked item container" do
      subject.pick(item)
      expect(picked_items_container.include?(item)).to eq(true)
    end
  end

  context "when initializing" do
    it "requires picked items container" do
      expect { PickItem.new(nil) }.to raise_error(ArgumentError)
    end
  end
end