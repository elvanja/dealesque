class SearchResult
  attr_accessor :items, :search_terms

  def initialize(attributes = {})
    raise ArgumentError unless attributes

    {search_terms: "", items: []}.each do |property, default_value|
      send("#{property}=", attributes[property] || default_value)
    end
  end
end