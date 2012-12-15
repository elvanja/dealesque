require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/json/hal'

require_relative 'item_image_representer'

module ItemRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :title
  property :url
  property :group
  hash :images, extend: ItemImageRepresenter, class: ItemImage
end