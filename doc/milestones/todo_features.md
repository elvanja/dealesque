# Features

## Digital content items issue

See if there is a wey to add kindle books to cart
Amazon builds item links that support this, but API doesn't
See https://affiliate-program.amazon.com/gp/associates/network/main.html

## Best offer

Let user pick a specific offer for an item (sticky)
Recalculate offer around sticky items
Allow for several offers to be remembered
Enable offer comparison

## Non empty home page

Show deal of the day or some other items that Amazon displays on their home page
So our home page would not be empty

## Amazon shop selection

Let user choose the Amazon shop from which to pull data
And to which put the items in the cart

## Internationalization

Enable different locales for UI
According to selected locale, offer to change Amazon shop

# Code

## Surrogate

https://github.com/JoshCheek/surrogate
replace real mocked/stubbed collaborating classes for surrogates
it retains contract but decouples from collaborating classes
(making changes doesn't force you to change collaborators as well)

## Rspec-Given

## Rails 4 compliance

http://rubysource.com/get-your-app-ready-for-rails-4/
Enable threadsafe, dalli or caching
Turbolinks / pjax for milestone 0.3

## Test other Amazon API libraries

Especially amazon-ecs
https://github.com/hakanensari/vacuum/
https://github.com/phoet/asin/
https://github.com/jugend/amazon-ecs/
http://www.caliban.org/ruby/ruby-aws/
https://github.com/christianhellsten/amazon-json-api

## Session storage in production

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