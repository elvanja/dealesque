class PickedItemsController < ApplicationController
  before_filter :retrieve_picked_items_from_session
  after_filter :store_picked_items_to_session, except: :index

  def index
  end

  def pick
    get_item_from_params { |item| PickItem.new(@picked_items).pick(item) }
    redirect_to action: :index
  end

  def unpick
    get_item_from_params { |item| UnpickItem.new(@picked_items).unpick(item) }
    redirect_to action: :index
  end

  private

  def retrieve_picked_items_from_session
    @picked_items = PickedItems.new
    @picked_items.extend(PickedItemsRepresenter).from_xml(session[:picked_items]) unless session[:picked_items] == nil # wtf? why do I need the nil check?
  end

  def store_picked_items_to_session
    session[:picked_items] = @picked_items.extend(PickedItemsRepresenter).to_xml
  end

  def get_item_from_params
    item = Item.new.extend(ItemRepresenter).from_xml(params[:item])
    yield item if block_given?
    item
  end
end
