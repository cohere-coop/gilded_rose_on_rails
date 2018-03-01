class NightlyQualityUpdateJob < ApplicationJob
  def perform
    Item.find_each do |item|
      job_klass = case item.name
      when "Aged Brie"
        AgedBrieQualityUpdateJob
      when "Sulfuras, Hand of Ragnaros"
        SulfurasQualityUpdateJob
      when "Backstage passes to a TAFKAL80ETC concert"
        BackstagePassesQualityUpdateJob
      else
        ItemQualityUpdateJob
      end
      job_klass.perform_later(item)
    end
  end
end
