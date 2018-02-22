class SulfurasQualityUpdateJob < ItemQualityUpdateJob
  def aging(item)
    0
  end

  def depreciation(item)
    0
  end

  def max_quality
    80
  end

  def min_quality
    80
  end
end