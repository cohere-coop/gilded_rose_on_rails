class ConjuredQualityUpdateJob < ItemQualityUpdateJob
  def depreciation(item)
    super * 2
  end
end