require 'roar/representer'
require 'roar/representer/json'

require_relative 'price_representer'
require_relative 'offer_representer'
require_relative 'item_image_representer'

module ItemRepresenter
  include Roar::Representer::JSON

  property :id
  property :title
  property :url
  property :group
  property :list_price, class: Price, extend: PriceRepresenter
  hash :images, class: ItemImage, extend: ItemImageRepresenter
  collection :offers, class: Offer, extend: OfferRepresenter
end