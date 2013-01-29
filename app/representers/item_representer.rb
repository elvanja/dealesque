require 'roar/representer'
require 'roar/representer/json'

require_relative 'item_image_representer'
require_relative 'offer_representer'

module ItemRepresenter
  include Roar::Representer::JSON

  property :id
  property :title
  property :url
  property :group
  hash :images, class: ItemImage, extend: ItemImageRepresenter
  collection :offers, class: Offer, extend: OfferRepresenter
end