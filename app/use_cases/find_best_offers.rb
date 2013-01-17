class FindBestOffers
  def for_picked_items(picked_items)
    raise ArgumentError.new("Missing picked items") unless picked_items

    picked_items.map do |picked_item|
      picked_item.offers.min {|a, b| a.price <=> b.price}
    end
  end
end