class ItemImageSet
  attr_accessor :category, :tiny, :small, :medium, :large, :swatch, :thumbnail

  def initialize(attributes = {})
    raise ArgumentError unless attributes

    attributes.each do |attribute, value|
      attribute_method = "#{attribute}=".to_sym
      send(attribute_method, value) if respond_to?(attribute_method)
    end
  end
end