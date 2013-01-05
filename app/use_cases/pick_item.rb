require 'forwardable'

class PickItem
  extend Forwardable
  def_delegators :@picked_items_container, :add
  alias_method :pick, :add

  def initialize(picked_items_container)
    raise ArgumentError unless picked_items_container
    @picked_items_container = picked_items_container
  end
end
