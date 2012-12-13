class Item
  attr_accessor :id, :title, :url, :group, :image_sets

  def initialize(attributes = {})
    raise ArgumentError unless attributes

    attributes.each do |attribute, value|
      attribute_method = "#{attribute}=".to_sym
      send(attribute_method, value) if respond_to?(attribute_method)
    end

    @image_sets ||= []
  end

  # TODO this is representer fix, it collects into arrays, find a way to directly put images in Item or at least create a hash directly
  def image_set(category)
    @image_sets.find { |image_set| image_set.category.to_s == category.to_s}
  end
end