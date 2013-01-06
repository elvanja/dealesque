# Milestone 0.1

## Browse Amazon items

Enable searching Amazon items
Show items that match the entered search term

## Pick items

Allow found items to be picked for later analysis
Picked items should be persisted throughout the session

## Put items in Amazon cart

Enable putting picked items in Amazon cart
Items in cart shold get Dealesue affiliate ID
Should work for Amazon logged in users and logged out too

## TODO

* add notifications to actions
  e.g. when picked an item, say it way picked, when unpicked, when unpick all etc.
* use [crack](https://github.com/jnunemaker/crack)
  to convert response xml to hash
* use [hashie](https://github.com/intridea/hashie)
  to parse response hash, try coercing parts directly to classes
* see if there is a wey to add kindle books to cart
  e.g. how Amazon builds item links https://affiliate-program.amazon.com/gp/associates/network/main.html
* test other libraries
  especially amazon-ecs
