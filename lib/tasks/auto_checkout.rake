namespace :users do
  desc "auto checkout users at EOD"
  task auto_checkout: :environment do
    AutoCheckOutJob.perform_now
  end
end
