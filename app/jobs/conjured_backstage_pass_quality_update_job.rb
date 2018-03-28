class ConjuredBackstagePassQualityUpdateJob < ItemQualityUpdateJob
  def depreciation(item)
    return item.quality if item.sell_in <= 0
    if item.name.match(/^Conjured/)
      2 * base_depreciation(item)
    else
      base_depreciation(item)
    end
  end

  def base_depreciation(item)
    case
    when item.sell_in <= 5
      -3
    when item.sell_in <= 10
      -2
    else
      -1
    end
  end
end