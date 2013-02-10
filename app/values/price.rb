class Price
  attr_accessor :amount, :currency, :formatted

  def initialize(attributes = {})
    raise ArgumentError.new("Missing attributes") unless attributes

    [:amount, :currency, :formatted].each do |property|
      send("#{property}=", attributes[property])
    end
  end
end

Price::NOT_AVAILABLE = Price.new({amount: 0, currency: "N/A", formatted: "N/A"})