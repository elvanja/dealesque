require 'roar/representer'
require 'roar/representer/json'

module PriceRepresenter
  include Roar::Representer::JSON

  property :fractional
  property :currency, getter: lambda { |opts| self.currency_as_string }
end