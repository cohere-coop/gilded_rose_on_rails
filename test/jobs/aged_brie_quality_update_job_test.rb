require 'test_helper'

class AgedBrieQualityUpdateJobTest < ActiveSupport::TestCase
  def test_aged_brie_before_sell_date
    item = Item.create(sell_in: 5, quality: 10, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 11
  end

  def test_aged_brie_with_max_quality_before_sell_date
    item = Item.create(sell_in: 5, quality: 50, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 50
  end

  def test_aged_brie_near_max_quality_on_sell_date
    item = Item.create(sell_in: 0, quality: 49, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -1
    assert_equal item.quality, 50
  end

  def test_aged_brie_with_max_quality_on_sell_date
    item = Item.create(sell_in: 0, quality: 50, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -1
    assert_equal item.quality, 50
  end

  def test_aged_brie_after_sell_date
    item = Item.create(sell_in: -1, quality: 10, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -2
    assert_equal item.quality, 12
  end

  def test_aged_brie_with_max_quality_after_sell_date
    item = Item.create(sell_in: -1, quality: 50, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -2
    assert_equal item.quality, 50
  end
end