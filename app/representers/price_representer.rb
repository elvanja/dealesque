require 'roar/representer'
require 'roar/representer/json'

module PriceRepresenter
  include Roar::Representer::JSON

  property :amount
  property :currency
  property :formatted
end