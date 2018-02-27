require 'test_helper'

class ItemQualityUpdateJobTest < ActiveSupport::TestCase
  def test_normal_item_before_sell_date
    item = Item.create(sell_in: 5, quality: 10)

    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 9, item.quality
  end

  def test_normal_item_on_sell_date
    item = Item.create(sell_in: 0, quality: 10)

    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -1, item.sell_in
    assert_equal 8, item.quality
  end

  def test_normal_item_after_sell_date
    item = Item.create(sell_in: -10, quality: 10)

    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -11, item.sell_in
    assert_equal 8, item.quality
  end

  def test_normal_item_of_zero_quality
    item = Item.create(sell_in: 5, quality: 0)

    ItemQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 4, item.sell_in
    assert_equal 0, item.quality
  end
end
