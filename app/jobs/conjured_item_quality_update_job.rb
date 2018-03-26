class ConjuredItemQualityUpdateJob < ItemQualityUpdateJob
  def depreciation(item)
    2 * super
  end
end