require 'roar/representer'
require 'roar/representer/json'

require_relative 'item_representer'

module PickedItemsRepresenter
  include Roar::Representer::JSON

  collection :items, extend: ItemRepresenter, class: Item
end