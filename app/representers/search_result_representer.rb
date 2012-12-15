require 'roar/representer'
require 'roar/representer/json'

require_relative "item_representer"

module SearchResultRepresenter
  include Roar::Representer::JSON

  property :search_terms
  collection :items, extend: ItemRepresenter, class: Item
end