require 'test_helper'

class ItemQualityUpdateJobTest < ActiveSupport::TestCase
  def test_nightly_update_depreciates_item
    item = Item.create(sell_in: 5, quality: 10)
    
    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 9, item.quality
  end

  def test_nightly_update_decrements_sell_in
    item = Item.create(sell_in: 5, quality: 10)
    
    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
  end

  def test_quality_cannot_go_below_min_quality
    item = Item.create(sell_in: 5, quality: 0)
    
    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 0, item.quality
  end

  def test_quality_cannot_be_above_max_quality
    item = Item.create(sell_in: 5, quality: 60)
    
    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 50, item.quality
  end

  def test_depreciation_before_sell_date
    item = Item.new(sell_in: 5, quality: 10)
    job = ItemQualityUpdateJob.new

    assert_equal 1, job.depreciation(item)
  end

  def test_depreciation_on_sell_date
    item = Item.new(sell_in: 0, quality: 10)
    job = ItemQualityUpdateJob.new

    assert_equal 2, job.depreciation(item)
  end

  def test_depreciation_after_sell_date
    item = Item.new(sell_in: 0, quality: 10)
    job = ItemQualityUpdateJob.new

    assert_equal 2, job.depreciation(item)
  end

  def test_aging
    item = Item.new(sell_in: 0, quality: 10)
    job = ItemQualityUpdateJob.new

    assert_equal 1, job.aging(item)
  end

  def test_min_quality
    job = ItemQualityUpdateJob.new

    assert_equal 0, job.min_quality
  end

  def test_max_quality
    job = ItemQualityUpdateJob.new

    assert_equal 50, job.max_quality
  end
end