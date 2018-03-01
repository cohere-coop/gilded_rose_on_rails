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

  def test_backstage_passes
    item = Item.create(sell_in: 11, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    NightlyQualityUpdateJob.perform_now
    item.reload

    assert_equal 10, item.sell_in
    assert_equal 11, item.quality
  end
end
