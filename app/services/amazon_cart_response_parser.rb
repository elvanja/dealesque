require 'nokogiri'

class AmazonCartResponseParser
  def parse(response)
    root = Nokogiri::XML(response.body).remove_namespaces!

    attributes = {}
    append_if_exists(attributes, :id, root, '//CartId')
    append_if_exists(attributes, :hmac, root, '//HMAC')
    append_if_exists(attributes, :encoded_hmac, root, '//URLEncodedHMAC')
    append_if_exists(attributes, :purchase_url, root, '//PurchaseURL')

    Cart.new(attributes)
  end

  private

  def append_if_exists(attributes, key, node, path, apply_method = nil)
    node.xpath(path).tap do |nodes|
      if nodes.first
        value = nodes.first.content
        value = value.send(apply_method) if apply_method
        attributes[key] = (value.respond_to?(:strip) ? value.strip : value)
      end
    end
  end
end