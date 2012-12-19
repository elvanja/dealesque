class SearchResult
  attr_accessor :search_terms, :items

  def initialize(attributes = {})
    raise ArgumentError unless attributes

    {search_terms: "", items: []}.each do |property, default_value|
      send("#{property}=", attributes[property] || default_value)
    end
  end
end