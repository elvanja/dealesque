Hardcoding Class name
  * Ruby Rogues Parley topic
  * Hexagonal - I guess it's OK when injecting from outside in (SearchResponse parser)
Structure of app, new folders (services, values, ... even lib) and how to autoload them in Rails and specs
Vacuum vs ASIN gems for accessing Amazon Product Advertising API - cover search and add to Cart
Parsing XML and JSON with the same Roar representer
XML parsing Roar limitations
Value object defaults and how this helps out of sync session data (represent from old version of object)

Sany Metz rules, Sonar Uncle Bob Use Case Driven etc.
1. Your class can be no longer than 100 lines of code.
2. Your methods can be no longer than 5 lines of code.
3. You can pass no more than four parameters and you can't just make it one big hash.
4. You Rails controller can only instantiate one object to do whatever it is that needs to be done.
5. You Rails view can only know about one instance variable.
6. Your Rails view should only send messages to that variable/object i.e., no Demeter violations.
The idea is to follow the rules, see where it leads

Published

In memory session store for Rails 3
Deploying Rails with Twitter Bootstrap on Heroku
Amazon API integration tests with VCR - how to circumvent the request signing (timestamp, etc.)
Nokogiri vs Crack & Hashie, code style and performance