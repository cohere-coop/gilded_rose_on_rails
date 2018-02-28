require 'test_helper'

class SulfurasQualityUpdateJobTest < ActiveSupport::TestCase
  def test_depreciation_before_sell_date
    item = Item.new(sell_in: 5, quality: 80, name: "Sulfuras, Hand of Ragnaros")
    job = SulfurasQualityUpdateJob.new

    assert_equal 0, job.depreciation(item)
  end

  def test_depreciation_on_sell_date
    item = Item.new(sell_in: 0, quality: 80, name: "Sulfuras, Hand of Ragnaros")
    job = SulfurasQualityUpdateJob.new

    assert_equal 0, job.depreciation(item)
  end

  def test_depreciation_after_sell_date
    item = Item.new(sell_in: -10, quality: 80, name: "Sulfuras, Hand of Ragnaros")
    job = SulfurasQualityUpdateJob.new

    assert_equal 0, job.depreciation(item)
  end

  def test_aging
    item = Item.new(sell_in: 10, quality: 80, name: "Sulfuras, Hand of Ragnaros")
    job = SulfurasQualityUpdateJob.new

    assert_equal 0, job.aging(item)
  end

  def test_min_quality
    job = SulfurasQualityUpdateJob.new

    assert_equal 80, job.min_quality
  end

  def test_max_quality
    job = SulfurasQualityUpdateJob.new

    assert_equal 80, job.max_quality
  end
end