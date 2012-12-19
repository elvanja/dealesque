require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/json/hal'

module ItemImageRepresenter
  include Roar::Representer::JSON::HAL

  property :url
  property :height
  property :width
  property :type
end