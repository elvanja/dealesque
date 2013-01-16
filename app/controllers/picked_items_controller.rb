class PickedItemsController < ApplicationController
  before_filter :retrieve_picked_items_from_session, except: :clear
  after_filter :store_picked_items_to_session, except: :index

  def index
  end

  def pick
    get_item_from_params do |item|
      PickItem.new(@picked_items).pick(item)
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
    create_new_picked_items
    flash[:notice] = "Meh, I'll just pick my nose instead..."
    redirect_to search_path
  end

  private

  def retrieve_picked_items_from_session
    create_new_picked_items
    @picked_items.from_json(session[:picked_items]) if session[:picked_items]
  end

  def store_picked_items_to_session
    session[:picked_items] = @picked_items.to_json
  end

  def get_item_from_params
    item = Item.new.extend(ItemRepresenter).from_json(params[:item])
    yield item if block_given?
    item
  end

  def create_new_picked_items
    @picked_items = PickedItems.new.extend(PickedItemsRepresenter)
  end
end