class Offer
  include Comparable

  attr_accessor :item, :price

  def initialize(attributes = {})
    raise ArgumentError.new("Missing attributes") unless attributes

    [:price, :item].each do |property|
      send("#{property}=", attributes[property])
    end
  end
end