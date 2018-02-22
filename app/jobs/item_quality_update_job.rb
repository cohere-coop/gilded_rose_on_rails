class ItemQualityUpdateJob < ApplicationJob
  def perform(item)
    new_attributes = {}

    new_attributes[:sell_in] = item.sell_in - aging(item)
    new_attributes[:quality] = item.quality - depreciation(item)
    new_attributes[:quality] = 0 if new_attributes[:quality] < min_quality
    new_attributes[:quality] = 50 if new_attributes[:quality] > max_quality

    item.update_attributes(new_attributes)
  end

  def aging(item)
    1
  end

  def depreciation(item)
    item.sell_in > 0 ? 1 : 2
  end

  def min_quality
    0
  end

  def max_quality
    50
  end
end
