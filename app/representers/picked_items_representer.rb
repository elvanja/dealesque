require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/xml'

require_relative "item_representer"

module PickedItemsRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::XML

  self.representation_wrap = "PickedItems"

  # from and wrap are needed for XML decoding
  collection :items, extend: ItemRepresenter, class: Item, from: "Item"
end