require 'test_helper'

class ConjuredQualityUpdateJobTest < ActiveSupport::TestCase
  def test_before_sell_date
    item = Item.create(quality: 5, sell_in: 10, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 9, item.sell_in
    assert_equal 3, item.quality
  end

  def test_min_quality_before_sell_date
    item = Item.create(quality: 0, sell_in: 10, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal 9, item.sell_in
    assert_equal 0, item.quality
  end

  def test_on_sell_date
    item = Item.create(quality: 5, sell_in: 0, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -1, item.sell_in
    assert_equal 1, item.quality
  end

  def test_min_quality_on_sell_date
    item = Item.create(quality: 0, sell_in: 0, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -1, item.sell_in
    assert_equal 0, item.quality
  end

  def test_after_sell_date
    item = Item.create(quality: 5, sell_in: -1, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -2, item.sell_in
    assert_equal 1, item.quality
  end

  def test_min_quality_before_sell_date
    item = Item.create(quality: 0, sell_in: -1, name: "Conjured Mana Cake")

    ConjuredQualityUpdateJob.perform_now(item)
    item.reload

    assert_equal -2, item.sell_in
    assert_equal 0, item.quality
  end
end
