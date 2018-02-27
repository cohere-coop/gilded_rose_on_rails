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

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal item.sell_in, 9
    assert_equal item.quality, 3
  end
end