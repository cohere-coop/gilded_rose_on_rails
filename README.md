# README

Welcome to the Gilded Rose Magickal Emporium! Or, more accurately, welcome to its inventory system.

Here at the Gilded Rose we buy and sell only the finest goods. Unfortunately, our
goods are constantly degrading in quality as they approach their sell by
date. We have a system in place that updates our inventory for us. The original developer of that system has since moved on to new
adventures.

## Getting Started

```
bin/setup
bin/rake
```

## An introduction to our system

- All items have a `sell_in` value which denotes the number of days we have
to sell the item
- All items have a `quality` value which denotes how valuable the item is
- At the end of each day our system lowers both values for every item

As the Gilded Rose offered more inventory, we ran into a few exceptions that we quickly updated the system to accommodate:

- Once the sell by date has passed, `quality` degrades twice as fast
- The `quality` of an item is never negative
- "Aged Brie" actually increases in `quality` the older it gets
- The `quality` of an item is never more than 50
- "Sulfuras", being a legendary item, never has to be sold or decreases
in `quality`
- "Backstage passes", like aged brie, increase in `quality` as time passes; `quality` increases by 2 when there are 10 days or less until the concert date,
and by 3 when there are 5 days or less, but `quality` drops to 0 after the
concert

Just for clarification, an item can never have its `quality` increase
above 50, however "Sulfuras" is a legendary item and as such its
`quality` is 80 and it never alters.

### Nightly system updates

We run a nightly `ActiveJob` to change `quality` and `sell_in`, `jobs/nightly_quality_update_job.rb`.
It works by fanning out a number of other queued jobs that we can run in a highly parallelized manner.

### DO NOT MODIFY THE DATABASE SCHEMA

The database schema stores the `sell_in` value as a time remaining integer.  
Please don't change the database schema!
Both our brick-and-mortar stores and our database servers are geographically located in the UMC (Coordinated Universal Magical Time) timezone, which as you know has inconsistent interactions with both Ruby and Rails core.
Previous changes to the database schema had unpleasant side effects, so all schema changes are now forbidden.


## Your task

We have recently signed a supplier of conjured items.
"Conjured" items degrade in `quality` twice as fast as normal items.

We're currently only carrying "Conjured Mana Cakes", and don't anticipate expanding our Conjured line of items in your lifetime.  Since it's such a simple task and we don't anticipate changes for a long time, we're allocating **10 minutes** for you to deliver this feature.

## Your next task

Great news! our sales rep just came through for us, and we'll be supplying our stores with all manner of Conjured items!

Your task is to support all "Conjured" items in our inventory system so that we can begin selling this exciting new category of items.


## Credits

Gilded Rose on Rails was created by Betsy Haibel, but it wouldn't exist without
* [Jim Weirich's Ruby version](https://github.com/jimweirich/gilded_rose_kata)
* [based on the original C# version](https://github.com/NotMyself/GildedRose)
* [Sandi Metz's POOD course, and her book with Katrina Owen, 99 Bottles of Oop](https://www.sandimetz.com/99bottles/)

We are tremendously grateful for those who came before us and led the way, and also to the brave handful of people who enthusiastically allowed us to lead them through the problem in its earlier stages.
