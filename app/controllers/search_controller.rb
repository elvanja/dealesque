class SearchController < ApplicationController
  def new
  end

  def search
    search = SearchAmazon.new(AmazonService.new(AMAZON_CREDENTIALS))
    @search_result = search.with_keywords(params[:search_terms])
  end
end
