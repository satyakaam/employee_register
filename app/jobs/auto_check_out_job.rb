class AutoCheckOutJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.includes(:events).find_each(batch_size: 500) do |user|
      next unless user.checked_in?

      user.check_out(true)
    end
  end
end
