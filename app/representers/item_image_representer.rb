require 'roar/representer'
require 'roar/representer/json'

module ItemImageRepresenter
  include Roar::Representer::JSON

  property :url
  property :height
  property :width
  property :type
end