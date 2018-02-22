namespace :inventory do
  desc "Manage degradation of item quality"
  task nightly_quality_update: :environment do
    NightlyQualityUpdateJob.perform_now
  end
end