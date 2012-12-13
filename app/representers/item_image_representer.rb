require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/xml'
require 'roar/representer/feature/coercion'

module ItemImageRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::XML
  include Roar::Representer::Feature::Coercion

  property :url, from: "URL"
  property :height, type: Integer, from: "Height"
  property :width, type: Integer, from: "Width"
end