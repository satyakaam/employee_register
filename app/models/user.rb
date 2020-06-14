class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :events

  validates :name, presence: true

  def checked_in?(occurred_at = Time.current)
    events.events_of_day(occurred_at).first&.check_in?
  end

  def check_out(auto = false)
    occurred_at = auto ? Time.current.change({ hour: 19 }) : Time.current
    event = events.build(occurred_at: occurred_at, event_type: :check_out, auto_generated: auto)
    event.save
  end

  def check_in
    event = events.build(occurred_at: Time.current, event_type: :check_in)
    event.save
  end
end
