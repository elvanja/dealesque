class Offer
  attr_accessor :item, :price, :currency, :formatted_price, :merchant, :condition

  def initialize(attributes = {})
    raise ArgumentError.new("Missing attributes") unless attributes

    [:price, :currency, :formatted_price, :merchant, :condition, :item].each do |property|
      send("#{property}=", attributes[property])
    end
  end
end