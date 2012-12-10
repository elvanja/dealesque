require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/xml'

module ItemRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::XML

  property :id, from: "ASIN"
  property :title, from: "Title", wrap: "ItemAttributes"
  property :url, from: "DetailPageURL"
  property :group, from: "ProductGroup", wrap: "ItemAttributes"
end