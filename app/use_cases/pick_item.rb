require_relative '../services/item_offer_listing_scraper'

class PickItem
  def initialize(picked_items_container, item_offer_listing_scraper = ItemOfferListingScraper.new)
    raise ArgumentError.new("Missing picked items container") unless picked_items_container
    raise ArgumentError.new("Item offer listing scraper must be defined") unless item_offer_listing_scraper
    @picked_items_container = picked_items_container
    @item_offer_listing_scraper = item_offer_listing_scraper
  end

  def pick(item)
    # TODO scrape in background and add to item in callback (or in some other way), scraping is too slow for the user to wait
    item.append_offers(@item_offer_listing_scraper.scrape_offers_for(item))
    @picked_items_container.add(item)
  end
end
