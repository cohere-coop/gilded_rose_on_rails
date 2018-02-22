require 'test_helper'

class BackstagePassesQualityUpdateJobTest < ActiveSupport::TestCase
  def test_well_before_sell_date
    item = Item.create(sell_in: 11, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 10
    assert_equal item.quality, 11
  end

  def test_max_quality_well_before_sell_date
    item = Item.create(sell_in: 11, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 10
    assert_equal item.quality, 50
  end

  def test_medium_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 10, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 9
    assert_equal item.quality, 12
  end

  def test_max_quality_medium_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 10, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 9
    assert_equal item.quality, 50
  end

  def test_medium_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 6, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 5
    assert_equal item.quality, 12
  end

  def test_max_quality_medium_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 6, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 5
    assert_equal item.quality, 50
  end

  def test_very_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 5, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 13
  end

  def test_max_quality_very_close_to_sell_date_upper_bound
    item = Item.create(sell_in: 5, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 50
  end

  def test_very_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 1, quality: 10, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 0
    assert_equal item.quality, 13
  end

  def test_max_quality_very_close_to_sell_date_lower_bound
    item = Item.create(sell_in: 1, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 0
    assert_equal item.quality, 50
  end

  def test_on_sell_date
    item = Item.create(sell_in: 0, quality: 50, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -1
    assert_equal item.quality, 0
  end

  def test_after_sell_date
    item = Item.create(sell_in: -1, quality: 0, name: "Backstage passes to a TAFKAL80ETC concert")
    
    BackstagePassesQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -2
    assert_equal item.quality, 0
  end
end