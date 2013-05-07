class PickedItemsController < ApplicationController
  before_filter :retrieve_picked_items_from_session, except: :clear
  after_filter :store_picked_items_to_session, except: :index

  def index
  end

  def pick
    get_item_from_params do |item|
      #PickItem.new(@picked_items).pick(item)
      @picked_items.add(item)
      flash[:notice] = "Better pick #{item.title} than the nose :-)"
    end
    redirect_to action: :index
  end

  def unpick
    get_item_from_params do |item|
      UnpickItem.new(@picked_items).unpick(item)
      flash[:notice] = "Yeah, you really didn't need that one"
    end
    redirect_to action: :index
  end

  def clear
    create_empty_picked_items
    flash[:notice] = "Meh, I'll just pick my nose instead..."
    redirect_to search_path
  end

  private

  # TODO this is used in CartController too, try to merge
  def retrieve_picked_items_from_session
    create_empty_picked_items
    PickedItemsRepresenter.new(@picked_items).from_json(session[:picked_items]) if session[:picked_items]
  end

  def create_empty_picked_items
    # TODO the listener should actually be the controller !!!!
    @picked_items = PickedItems.new
    @picked_items.add_listener(ItemOfferListingScraper.new)
  end

  def store_picked_items_to_session
    session[:picked_items] = PickedItemsRepresenter.new(@picked_items).to_json
  end

  def get_item_from_params
    item = Item.new
    ItemRepresenter.new(item).from_json(params[:item])
    yield item if block_given?
    item
  end
end