require 'test_helper'

class NightlyQualityUpdateJobTest < ActiveSupport::TestCase
  def test_normal_item
    item = Item.create(sell_in: 5, quality: 10)

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 9
  end

  def test_aged_brie
    item = Item.create(sell_in: 5, quality: 10, name: "Aged Brie")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 11
  end

  def test_sulfuras
    item = Item.create(sell_in: 5, quality: 80, name: "Sulfuras, Hand of Ragnaros")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal item.sell_in, 5
    assert_equal item.quality, 80
  end

  def test_backstage_passes
    item = Item.create(sell_in: 11, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal item.sell_in, 10
    assert_equal item.quality, 11
  end

  def test_conjured
    item = Item.create(quality: 5, sell_in: 10, name: "Conjured Mana Cake")
    item2 = Item.create(quality: 5, sell_in: 10, name: "Conjured Aged Brie")
    item3 = Item.create(quality: 5, sell_in: 10, name: "Conjured Beef Jerky")

    NightlyQualityUpdateJob.perform_now
    item.reload
    item2.reload
    item3.reload

    assert_equal 9, item.sell_in
    assert_equal 3, item.quality

    assert_equal 9, item2.sell_in
    assert_equal 7, item2.quality

    assert_equal 9, item3.sell_in
    assert_equal 3, item3.quality
  end
end
