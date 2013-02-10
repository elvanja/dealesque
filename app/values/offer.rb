class Offer
  # TODO Condition should be enum
  attr_accessor :price, :merchant, :condition, :item

  def initialize(attributes = {})
    raise ArgumentError.new("Missing attributes") unless attributes

    [:price, :merchant, :condition, :item].each do |property|
      send("#{property}=", attributes[property])
    end
  end
end