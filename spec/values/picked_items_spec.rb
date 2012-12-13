require 'spec_helper_without_rails'

describe PickedItems do
  context "when initializing" do
    it "contains no items" do
      expect(subject.empty?).to eq(true)
    end
  end

  context "when adding items" do
    let(:item) { Item.new }

    context "with new item" do
      it "stores item" do
        subject.add(item)
        expect(subject.include?(item)).to eq(true)
      end
    end

    context "with existing item" do
      it "doesn't duplicate items" do
        subject.add(item)
        subject.add(item)
        expect(subject.include?(item)).to eq(true)
        expect(subject.size).to eq(1)
      end
    end
  end

  context "when removing items" do
    let(:item) { Item.new }
    before(:each) { subject.add(item) }

    it "removes item" do
      subject.remove(item)
      expect(subject.include?(item)).to eq(false)
    end
  end
end