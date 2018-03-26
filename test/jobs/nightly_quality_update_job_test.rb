require 'test_helper'

class NightlyQualityUpdateJobTest < ActiveSupport::TestCase
  def test_normal_item
    item = Item.create(sell_in: 5, quality: 10)

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 9, item.quality
  end

  def test_aged_brie
    item = Item.create(sell_in: 5, quality: 10, name: "Aged Brie")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 11, item.quality
  end

  def test_sulfuras
    item = Item.create(sell_in: 5, quality: 80, name: "Sulfuras, Hand of Ragnaros")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal 5, item.sell_in
    assert_equal 80, item.quality
  end

  def test_backstage_pass
    item = Item.create(sell_in: 11, quality: 10, name: "Backstage pass to a TAFKAL80ETC concert")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal 10, item.sell_in
    assert_equal 11, item.quality
  end

  def test_conjured_item
    cake = Item.create(sell_in: 11, quality: 10, name: "Conjured Mana Cake")
    milk = Item.create(sell_in: 11, quality: 10, name: "Conjured Milk")
    kale = Item.create(sell_in: 11, quality: 10, name: "Conjured Kale")

    NightlyQualityUpdateJob.perform_now
    cake.reload
    milk.reload
    kale.reload

    assert_equal 10, cake.sell_in
    assert_equal  8, cake.quality
    assert_equal 10, milk.sell_in
    assert_equal  8, milk.quality
    assert_equal 10, kale.sell_in
    assert_equal  8, kale.quality
  end
end
