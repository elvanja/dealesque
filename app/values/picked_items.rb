require 'forwardable'

class PickedItems
  extend Forwardable
  def_delegators :@items, :size, :include?, :delete, :empty?
  alias_method :remove, :delete

  def initialize
    @items = []
  end

  # TODO if item quantity is needed, add it as behaviour to item using a module
  def add(item)
    @items << item unless include?(item)
  end
end