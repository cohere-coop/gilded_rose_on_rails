# README

Welcome to the Gilded Rose Magickal Emporium! Or, more accurately, welcome to its inventory system.

Here at the Gilded Rose we buy and sell only the finest goods. Unfortunately, our
goods are constantly degrading in quality as they approach their sell by
date. We have a system in place that updates our inventory for us. It was
developed by a no-nonsense type named Leeroy, who has moved on to new
adventures. Your task is to add the new feature to our system so that we
can begin selling a new category of items. First an introduction to our
system:

- All items have a `sell_in` value which denotes the number of days we have
to sell the item
- All items have a `quality` value which denotes how valuable the item is
- At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, `quality` degrades twice as fast
- The `quality` of an item is never negative
- "Aged Brie" actually increases in `quality` the older it gets
- The `quality` of an item is never more than 50
- "Sulfuras", being a legendary item, never has to be sold or decreases
in `quality`
- "Backstage passes", like aged brie, increase in `quality` as time passes; `quality` increases by 2 when there are 10 days or less until the concert date,
and by 3 when there are 5 days or less, but `quality` drops to 0 after the
concert

We have recently signed a supplier of conjured items. "Conjured" items degrade in `quality` twice as fast as normal items. A previous development team was hired to complete this feature, but they were unfortunately very literal in their adherence to acceptance test cases and have been fired. They interpreted "Conjured Mana Cakes" as the only potential conjured items, when in fact any item (except legendary items) could potentially be a conjured item. Please let us know early on if you have any further questions about the definition of conjured items. We would like to avoid other unpleasant situations like the one that consumed our previous development team.

**Important!** Right now the database schema stores the `sell_in` value as a time remaining integer. Also, we run a nightly `ActiveJob` to change `quality` and `sell_in` that works by fanning out a number of other queued jobs that we can run in a highly parallelized manner. These are both important architectural properties -- magical timezones are even worse than normal time zones, *trust us*. Please don't change the database schema or the job parallelization structure while you fix these bugs! Our insurance does not cover the potential negative effects that destablilizing Sulfuras in this way could cause. And, of course, even if it did you would be financially responsible for any ensuing property damage rather than us.

Just for clarification, an item can never have its `quality` increase
above 50, however "Sulfuras" is a legendary item and as such its
`quality` is 80 and it never alters.

## Getting Started

```
bin/setup
bin/rake
```

## Credits

Gilded Rose on Rails was created by Betsy Haibel, but it wouldn't exist without
* [Jim Weirich's Ruby version](https://github.com/jimweirich/gilded_rose_kata)
* [based on the original C# version](https://github.com/NotMyself/GildedRose)
* [Sandi Metz's POOD course, and her book with Katrina Owen, 99 Bottles of Oop](https://www.sandimetz.com/99bottles/)

We are tremendously grateful for those who came before us and led the way, and also to the brave handful of people who enthusiastically allowed us to lead them through the problem in its earlier stages.
