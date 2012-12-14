require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/xml'

require_relative 'item_image_representer'

module ItemImageSetRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::XML

  self.representation_wrap = "ImageSet"

  property :category, from: "Category", attribute: true
  property :tiny, extend: ItemImageRepresenter, class: ItemImage, from: "TinyImage"
  property :small, extend: ItemImageRepresenter, class: ItemImage, from: "SmallImage"
  property :medium, extend: ItemImageRepresenter, class: ItemImage, from: "MediumImage"
  property :large, extend: ItemImageRepresenter, class: ItemImage, from: "LargeImage"
  property :swatch, extend: ItemImageRepresenter, class: ItemImage, from: "SwatchImage"
  property :thumbnail, extend: ItemImageRepresenter, class: ItemImage, from: "ThumbnailImage"
end