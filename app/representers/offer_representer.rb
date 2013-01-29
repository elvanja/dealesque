require 'roar/representer'
require 'roar/representer/json'

module OfferRepresenter
  include Roar::Representer::JSON

  property :price
  property :currency
  property :formatted_price
  property :merchant
  property :condition
end