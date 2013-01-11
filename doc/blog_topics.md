Crack / Hashie vs Nokogiri, performance and code style
  * [crack](https://github.com/jnunemaker/crack)
  * [hashie](https://github.com/intridea/hashie)
  Test results parsing Amazon response with 9 items in 100 consecutive runs
  Nokogiri: 1.18, 1.26, 1.27, 1.33, 1.23
  Crack & Hashie: 7.06, 7.87, 7.56, 7.58, 7.44

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
