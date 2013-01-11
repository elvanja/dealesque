require 'nokogiri'

class AmazonSearchResponseParser
  include AmazonParser

  def parse(response)
    root = Nokogiri::XML(response.body).remove_namespaces!

    attributes = {}
    attributes[:search_terms] = parse_search_terms(root)
    attributes[:items] = parse_items(root)

    SearchResult.new(attributes)
  end

  private

  def parse_search_terms(node)
    parse_value(node, '//OperationRequest/Arguments/Argument[@Name="Keywords"]/@Value')
  end

  def parse_items(node)
    node.xpath('//Items/Item').map do |item_node|
      create_item_from(item_node)
    end
  end

  def create_item_from(node)
    attributes = {}
    attributes[:id] = parse_value(node, './ASIN')
    attributes[:title] = parse_value(node, './ItemAttributes/Title')
    attributes[:url] = parse_value(node, './DetailPageURL')
    attributes[:group] = parse_value(node, './ItemAttributes/ProductGroup')
    attributes[:images] = parse_item_images(node)
    Item.new(attributes)
  end

  def parse_item_images(node)
    image_sets = node.xpath('./ImageSets/ImageSet')
    return if image_sets.children.size == 0

    image_set = image_sets.find {|image_set| image_set.attribute('Category').value == 'primary'} || image_sets.first
    image_set.xpath('./*').inject(Hash.new) do |images, image_node|
      image = create_item_image_from(image_node)
      images[image.type] = image
      images
    end
  end

  def create_item_image_from(node)
    attributes = {}
    attributes[:url] = parse_value(node, './URL')
    attributes[:height] = parse_value(node, './Height', :to_i)
    attributes[:width] = parse_value(node, './Width', :to_i)
    attributes[:type] = node.name.gsub("Image", "").downcase
    ItemImage.new(attributes)
  end
end