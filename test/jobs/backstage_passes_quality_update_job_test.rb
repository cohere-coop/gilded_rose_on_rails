require 'test_helper'

class BackstagePassesQualityUpdateJobTest < ActiveSupport::TestCase
  def test_well_before_sell_date
    item = Item.create(sell_in: 11, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 10, item.sell_in
    assert_equal 11, item.quality
  end

  def test_max_quality_well_before_sell_date
    item = Item.create(sell_in: 11, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 10, item.sell_in
    assert_equal 50, item.quality
  end

  def test_medium_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 10, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 9, item.sell_in
    assert_equal 12, item.quality
  end

  def test_max_quality_medium_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 10, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 9, item.sell_in
    assert_equal 50, item.quality
  end

  def test_medium_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 6, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 5, item.sell_in
    assert_equal 12, item.quality
  end

  def test_max_quality_medium_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 6, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 5, item.sell_in
    assert_equal 50, item.quality
  end

  def test_very_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 5, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 13, item.quality
  end

  def test_max_quality_very_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 5, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 50, item.quality
  end

  def test_very_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 1, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 0, item.sell_in
    assert_equal 13, item.quality
  end

  def test_max_quality_very_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 1, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 0, item.sell_in
    assert_equal 50, item.quality
  end

  def test_on_sell_date
    item = Item.create(sell_in: 0, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -1, item.sell_in
    assert_equal 0, item.quality
  end

  def test_after_sell_date
    item = Item.create(sell_in: -1, quality: 0, name: "Backstage passes to a TAFKAL80ETC concert")

    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -2, item.sell_in
    assert_equal 0, item.quality
  end
end
