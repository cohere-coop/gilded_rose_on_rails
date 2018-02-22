class AgedBrieQualityUpdateJob < ItemQualityUpdateJob
  def depreciation(item)
    super * -1
  end
end