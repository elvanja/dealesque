require 'nokogiri'

class AmazonResponseParser
  # search result => search terms + items => item => data + images => image
  # Items => Item => ImageSets => ImageSet => Image
  # Items => Item => ItemAttributes
  def parse(response)
    root = Nokogiri::XML(response.body).remove_namespaces!

    attributes = {}
    append_search_terms_from(root, attributes)
    append_items(root, attributes)

    SearchResult.new(attributes)
  end

  private

  def append_search_terms_from(root, attributes)
    append_if_exists(attributes, :search_terms, root, '//OperationRequest/Arguments/Argument[@Name="Keywords"]/@Value')
  end

  def append_items(root, attributes)
    attributes[:items] = root.xpath('//Items/Item').map do |node|
      create_item_from(node)
    end
  end

  def create_item_from(node)
    attributes = {}
    append_if_exists(attributes, :id, node, './ASIN')
    append_if_exists(attributes, :title, node, './ItemAttributes/Title')
    append_if_exists(attributes, :url, node, './DetailPageURL')
    append_if_exists(attributes, :group, node, './ItemAttributes/ProductGroup')
    attributes[:images] = node.xpath('./ImageSets/ImageSet[@Category="primary"]/*').inject(Hash.new) do |images, image_node|
      image = create_item_image_from(image_node)
      images[image.type] = image
      images
    end
    Item.new(attributes)
  end

  def create_item_image_from(node)
    attributes = {}
    append_if_exists(attributes, :url, node, './URL')
    append_if_exists(attributes, :height, node, './Height', :to_i)
    append_if_exists(attributes, :width, node, './Width', :to_i)
    attributes[:type] = node.name.gsub("Image", "").downcase
    ItemImage.new(attributes)
  end

  def append_if_exists(attributes, key, node, path, apply_method = nil)
    node.xpath(path).tap do |nodes|
      if nodes.first
        value = nodes.first.content
        value = value.send(apply_method) if apply_method
        attributes[key] = value
      end
    end
  end
end