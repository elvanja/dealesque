require_relative '../services/item_offer_listing_scraper'

class PickItem
  def initialize(picked_items_container, item_offer_listing_scraper = ItemOfferListingScraper.new)
    raise ArgumentError.new("Missing picked items container") unless picked_items_container
    raise ArgumentError.new("Item offer listing scraper must be defined") unless item_offer_listing_scraper

    @picked_items_container = picked_items_container

    @item_offer_listing_scraper = item_offer_listing_scraper
    @item_offer_listing_scraper.add_listener(self)
  end

  def pick(item)
    @picked_items_container.add(item)
    @item_offer_listing_scraper.scrape_offers_for(item)
    item
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event_name, *args)
    @listeners && @listeners.each do |listener|
      if listener.respond_to?(event_name)
        listener.public_send(event_name, self, *args)
      end
    end
  end

  def on_offers_scrapped_for(scraper, item, scraped_offers)
    item.append_offers(scraped_offers)
    notify_listeners(:on_offers_added_to, item)
    item
  end
end
