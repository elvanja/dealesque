class Offer
  # TODO Condition should be enum / class
  attr_accessor :id, :price, :merchant, :condition, :item

  def initialize(attributes = {})
    raise ArgumentError.new("Missing attributes") unless attributes

    [:id, :price, :merchant, :condition, :item].each do |property|
      send("#{property}=", attributes[property])
    end
  end
end