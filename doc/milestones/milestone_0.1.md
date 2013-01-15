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

* Rails 4 compliance
* use https://github.com/JoshCheek/surrogate for rspec
  replace real mocked/stubbed collaborating classes for surrogates
  it retains contract but decouples from collaborating classes
  (making changes doesn't force you to change collaborators as well)