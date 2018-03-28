require 'test_helper'

class ConjuredBackstagePassQualityUpdateJobTest < ActiveSupport::TestCase
  def test_depreciation_well_before_sell_date
    item = Item.new(sell_in: 11, quality: 10, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal -2, job.depreciation(item)
  end

  def test_depreciation_medium_close_to_sell_date_upper_bound
    item = Item.new(sell_in: 10, quality: 10, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal -4, job.depreciation(item)
  end

  def test_depreciation_medium_close_to_sell_date_lower_bound
    item = Item.new(sell_in: 6, quality: 10, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal -4, job.depreciation(item)
  end

  def test_depreciation_very_close_to_sell_date_upper_bound
    item = Item.new(sell_in: 5, quality: 10, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal -6, job.depreciation(item)
  end

  def test_depreciation_very_close_to_sell_date_lower_bound
    item = Item.new(sell_in: 1, quality: 10, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal -6, job.depreciation(item)
  end

  def test_depreciation_on_sell_date
    item = Item.new(sell_in: 0, quality: 10, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal 10, job.depreciation(item)
  end

  def test_depreciation_after_sell_date
    item = Item.new(sell_in: 0, quality: 0, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal 0, job.depreciation(item)
  end

  def test_aging
    item = Item.new(sell_in: 0, quality: 0, name: "Conjured Backstage passes to a TAFKAL80ETC concert")
    job = ConjuredBackstagePassQualityUpdateJob.new

    assert_equal 1, job.aging(item)
  end

  def test_min_quality
    job = ConjuredBackstagePassQualityUpdateJob.new
    assert_equal 0, job.min_quality
  end

  def test_max_quality
    job = ConjuredBackstagePassQualityUpdateJob.new
    assert_equal 50, job.max_quality
  end
end