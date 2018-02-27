require 'test_helper'

class AgedBrieQualityUpdateJobTest < ActiveSupport::TestCase
  def test_aged_brie_before_sell_date
    item = Item.create(sell_in: 5, quality: 10, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 11, item.quality
  end

  def test_aged_brie_with_max_quality_before_sell_date
    item = Item.create(sell_in: 5, quality: 50, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 50, item.quality
  end

  def test_aged_brie_near_max_quality_on_sell_date
    item = Item.create(sell_in: 0, quality: 49, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -1, item.sell_in
    assert_equal 50, item.quality
  end

  def test_aged_brie_with_max_quality_on_sell_date
    item = Item.create(sell_in: 0, quality: 50, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -1, item.sell_in
    assert_equal 50, item.quality
  end

  def test_aged_brie_after_sell_date
    item = Item.create(sell_in: -1, quality: 10, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -2, item.sell_in
    assert_equal 12, item.quality
  end

  def test_aged_brie_with_max_quality_after_sell_date
    item = Item.create(sell_in: -1, quality: 50, name: "Aged Brie")

    AgedBrieQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -2, item.sell_in
    assert_equal 50, item.quality
  end
end
