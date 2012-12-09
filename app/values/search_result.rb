class SearchResult
  attr_accessor :items

  def initialize(attributes = {})
    raise ArgumentError unless attributes
    @items = attributes[:items]
  end
end