require 'test_helper'

class SulfurasQualityUpdateJobTest < ActiveSupport::TestCase
  def test_before_sell_date
    item = Item.create(sell_in: 5, quality: 80, name: "Sulfuras, Hand of Ragnaros")

    SulfurasQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 5
    assert_equal item.quality, 80
  end

  def test_on_sell_date
    item = Item.create(sell_in: 0, quality: 80, name: "Sulfuras, Hand of Ragnaros")

    SulfurasQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 0
    assert_equal item.quality, 80
  end

  def test_after_sell_date
    item = Item.create(sell_in: -5, quality: 80, name: "Sulfuras, Hand of Ragnaros")

    SulfurasQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -5
    assert_equal item.quality, 80
  end
end