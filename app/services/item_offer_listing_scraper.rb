require 'nokogiri'
require 'mechanize'

class ItemOfferListingScraper
  include AmazonParser

  def scrape_offers_for(item)
    root = Nokogiri::HTML(get_more_offers_page(item.more_offers_url))
    scrape_offers(root)
  end

  private

  def get_more_offers_page(more_offers_url)
    agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    page = agent.get(more_offers_url)
    page.content.strip
  end

  def scrape_offers(node)
    node.css('div.resultsset tbody.result').map do |offer_node|
      create_offer_from(offer_node)
    end
  end

  def create_offer_from(node)
    attributes = {}
    attributes[:merchant] = parse_value(node, './/div[@class = "seller"]/a/b')
    attributes[:condition] = Condition.from(parse_value(node, './/div[@class = "condition"]').gsub("\n", " ").strip)
    attributes[:price] = create_price_from(node.xpath('.//span[@class = "price"]').first)
    Offer.new(attributes)
  end

  def create_price_from(node)
    return unless node
    attributes = {}
    #attributes[:amount] = parse_value(node, './Amount', :to_i) / 100.0
    #attributes[:currency] = parse_value(node, './CurrencyCode')
    #attributes[:formatted] = parse_value(node, './FormattedPrice')
    attributes[:formatted] = node.content
    Price.new(attributes)
  end
end