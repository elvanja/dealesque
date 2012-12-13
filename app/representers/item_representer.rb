require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/xml'

require_relative 'item_image_set_representer'

module ItemRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::XML

  property :id, from: "ASIN"
  property :title, from: "Title", wrap: "ItemAttributes"
  property :url, from: "DetailPageURL"
  property :group, from: "ProductGroup", wrap: "ItemAttributes"
  collection :image_sets, extend: ItemImageSetRepresenter, class: ItemImageSet, from: "ImageSet", wrap: "ImageSets"
end