# TODO Price => Money

Use Money to be more smart about showing prices in selected currency
https://github.com/RubyMoney/money

# TODO Implement controllers to be testable

Use gem at https://github.com/xaviershay/poniard

# TODO View consolidation and presentation

https://github.com/sentientmonkey/presenter-example/blob/master/lib/presenter.rb
https://github.com/sentientmonkey/presenter-example/blob/master/app/models/user_registration.rb
https://github.com/zendesk/curly-templates

# TODO Mutating code coverage

http://solnic.eu/2013/01/23/mutation-testing-with-mutant.html

# TODO App version

Tags for releases or hot-fixes should do, no need to enter it manually
Display version somewhere on site
http://stackoverflow.com/questions/11199553/where-to-define-rails-apps-version-number

# TODO Paratrooper for Heroku deployments

http://blog.hashrocket.com/posts/when-pushing-just-isn-t-getting-the-job-done

# TODO Surrogate

https://github.com/JoshCheek/surrogate
replace real mocked/stubbed collaborating classes for surrogates
it retains contract but decouples from collaborating classes
(making changes doesn't force you to change collaborators as well)

# TODO Rspec-Given

http://rubysource.com/rspec-given/

# TODO Rails 4 compliance

http://rubysource.com/get-your-app-ready-for-rails-4/
Enable threadsafe, dalli or caching
Turbolinks / pjax for milestone 0.3

# TODO Test other Amazon API libraries

Especially amazon-ecs
https://github.com/hakanensari/vacuum/
https://github.com/phoet/asin/
https://github.com/jugend/amazon-ecs/
http://www.caliban.org/ruby/ruby-aws/
https://github.com/christianhellsten/amazon-json-api

# TODO Apply benchmarking gem instead of manually calculating average

Related to Nokogiri vs Crack & Hashie
http://gistflow.com/posts/136-benchmarking-with-ruby

# TODO Benchmark Roar transformations with extend and with direct class inclusion

http://tonyarcieri.com/dci-in-ruby-is-completely-broken

# TODO Session storage in production

Needed for picked items storage

Workflow

* JSON picked items representation is stored in user session
* For picked requests, picked items are retrieved from session
* Session expiration
    * If every request refreshes (even non related), 10 minutes is enough
      This means that we are effectively keeping sessions alive for active users
    * If only picked items requests are refreshing the session, 30 minutes should be enough

We can't store only item IDs because not only Amazon related data is present in Item
E.g. offer selection for picked item can't be restored from Amazon

Currently, each item JSON representation takes about 2KB
That is ~ 12.000 items in 25MB
Or ~ 2.000 sessions

Since session storage is centralised, requests from all instances should be using the same session

Solutions, Heroku related

* DB
    * expiration requires CRON job that cleans up the stale sessions
    * [this](http://errtheblog.com/posts/22-sessions-n-such) article suggests MySQL and bare metal adapters
    * active record store is also an option
    * mongo [has](http://docs.mongodb.org/manual/tutorial/expire-data/) expire option
    * Heroku free options
        * [Postgres](https://addons.heroku.com/heroku-postgresql) 10.000 row limit => 10.000 sessions
        * [MySQL](https://addons.heroku.com/cleardb) 5 MB => 400 sessions
        * [MongoLab](https://addons.heroku.com/mongolab) 496 MB => 40.000 sessions
        * [MongoHQ](https://addons.heroku.com/mongohq) 512 MB, 50 MB memory => 40.000 sessions
* Cache
    * Memcached
        * Loosing a part of cache means we loose the intire session
        * Heroku free options
            * [MemCachier](https://addons.heroku.com/memcachier) 25 MB => 2.000 sessions
    * Redis
        * Loosing a part of cache means we loose the intire session
        * Heroku free options
            * [RedisToGo](https://addons.heroku.com/redistogo) 5 MB => 400 sessions
            * [MyRedis](https://addons.heroku.com/myredis) 100 MB => 8.000 sessions
            * [RedisCloud](https://addons.heroku.com/rediscloud) 1 GB => 80.000 sessions

To make picked items session even more persistent

* place ID/ASIN of picked items in cookie session
* when restoring session, if items exist, use them otherwise fetch from Amazon

Amazon remote cart could be used as well
The only drawback is that not all domain data will be contained in the cart
So for each request, all the items would need to be looked up on Amazon
Seems like too much traffic (unless some sort of caching is used)