require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/xml'

module ItemRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::XML

  property :title
  property :description
end