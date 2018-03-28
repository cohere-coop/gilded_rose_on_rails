class ConjuredBackstagePassQualityUpdateJob < AgedBrieQualityUpdateJob
  def depreciation(item)
    return item.quality if item.sell_in <= 0
    case
    when item.sell_in <= 5
      -3 * 2
    when item.sell_in <= 10
      -2 * 2
    else
      aged_brie_depreciation(item) * 2
    end
  end

  def aged_brie_depreciation(item)
    (item.sell_in > 0 ? 1 : 2) * -1
  end
end