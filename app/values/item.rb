class Item
  attr_accessor :title, :description

  def initialize(attributes = {})
    raise ArgumentError unless attributes

    @title = attributes[:title]
    @description = attributes[:description]
  end
end