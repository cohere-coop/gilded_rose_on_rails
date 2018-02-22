require 'test_helper'

class ItemQualityUpdateJobTest < ActiveSupport::TestCase
  def test_normal_item_before_sell_date
    item = Item.create(sell_in: 5, quality: 10)
    
    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 9
  end

  def test_normal_item_on_sell_date
    item = Item.create(sell_in: 0, quality: 10)
    
    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -1
    assert_equal item.quality, 8
  end

  def test_normal_item_after_sell_date
    item = Item.create(sell_in: -10, quality: 10)

    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -11
    assert_equal item.quality, 8
  end

  def test_normal_item_of_zero_quality
    item = Item.create(sell_in: 5, quality: 0)

    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 4
    assert_equal item.quality, 0
  end
end