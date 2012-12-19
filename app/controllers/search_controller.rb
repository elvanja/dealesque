class SearchController < ApplicationController
  def new
  end

  def search
    provider = Vacuum.new.tap { |provider| provider.configure(AMAZON_CREDENTIALS) }
    search = SearchAmazon.new(AmazonService.new(provider))
    @search_result = search.with_keywords(params[:search_terms])
  end
end
