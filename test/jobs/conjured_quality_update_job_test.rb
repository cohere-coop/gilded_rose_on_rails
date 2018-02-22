require 'test_helper'

class ConjuredQualityUpdateJobTest < ActiveSupport::TestCase
  def test_before_sell_date
    item = Item.create(quality: 5, sell_in: 10, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 9
    assert_equal item.quality, 3
  end

  def test_min_quality_before_sell_date
    item = Item.create(quality: 0, sell_in: 10, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, 9
    assert_equal item.quality, 0
  end

  def test_on_sell_date
    item = Item.create(quality: 5, sell_in: 0, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -1
    assert_equal item.quality, 1
  end

  def test_min_quality_on_sell_date
    item = Item.create(quality: 0, sell_in: 0, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -1
    assert_equal item.quality, 0
  end

  def test_after_sell_date
    item = Item.create(quality: 5, sell_in: -1, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -2
    assert_equal item.quality, 1
  end

  def test_min_quality_before_sell_date
    item = Item.create(quality: 0, sell_in: -1, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal item.sell_in, -2
    assert_equal item.quality, 0
  end
end