# Milestone 0.2

## Find the best offer

Using picked items, search the offers for each item and find the least expensive combination
Use used item offers by default
Try to find the most common used offer merchant to reduce postage costs
If available, use the postage information too

## Put items in Amazon cart

Put items with the computed offer / price / merchant

## Browse Amazon items

Show Amazon list price
Show smallest used price, if available

## Picked items

### When not computed

Show Amazon list price
Show smallest used price, if available

### When computed

Show computed price per item
Show merchant
Group items by merchant (colorize)

# TODO

* find all the offers by scraping item detail pages
  get all the data on search
  if considerably slowing things, do it on pick item or when calculating best offer
* find shipping options and costs
  if nothing else, use web scraping
  take care to calculate correctly for amazon logged in and not logged in user
* find more items
  current limit is 10
* create a table of merchant offers / items combinations
  so the user can easily see which merchant offers which items