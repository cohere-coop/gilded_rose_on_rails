class ConjuredBackstagePassQualityUpdateJob < AgedBrieQualityUpdateJob
  def depreciation(item)
    return item.quality if item.sell_in <= 0
    case
    when item.sell_in <= 5
      -3 * 2
    when item.sell_in <= 10
      -2 * 2
    else
      super * 2
    end
  end
end