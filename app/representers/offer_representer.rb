require 'roar/representer'
require 'roar/representer/json'

require_relative 'price_representer'

module OfferRepresenter
  include Roar::Representer::JSON

  property :price, class: Price, extend: PriceRepresenter
  property :merchant
  property :condition
end