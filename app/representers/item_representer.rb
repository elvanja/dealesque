require 'roar/representer'
require 'roar/representer/json'

require_relative 'item_image_representer'

module ItemRepresenter
  include Roar::Representer::JSON

  property :id
  property :title
  property :url
  property :group
  hash :images, extend: ItemImageRepresenter, class: ItemImage
end