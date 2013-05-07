require 'forwardable'

class PickedItems
  extend Forwardable
  def_delegators :@items, :size, :include?, :delete, :empty?, :each, :each_with_index, :map, :collect
  alias_method :remove, :delete
  attr_accessor :items # needed for roar

  def initialize
    @items = []
  end

  # TODO if item quantity is needed, add it as behaviour to item using a module
  def add(item)
    return item if include?(item)
    @items << item
    notify_listeners(:on_item_picked, item)
    item
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event_name, *args)
    @listeners && @listeners.each do |listener|
      if listener.respond_to?(event_name)
        listener.public_send(event_name, *args)
      end
    end
  end
end