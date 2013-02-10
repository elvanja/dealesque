class AddScrapedItemOffersToItem
  def initialize(scraper)
    raise ArgumentError.new("Missing item offer listing scraper") unless scraper
    @scraper = scraper
  end

  def for(item)
    item.append_offers(@scraper.scrape_offers_for(item))
  end
end