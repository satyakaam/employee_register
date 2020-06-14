class Event < ApplicationRecord
  belongs_to :user

  enum event_type: { check_in: 'Check In', check_out: 'Check Out' }

  default_scope { order(occurred_at: :desc) }
  scope :events_of_day, -> (occurred_at) { where(occurred_at: occurred_at.beginning_of_day..occurred_at.end_of_day) }
  scope :filter_by_dates, -> (start_time, end_time) { where(occurred_at: start_time.beginning_of_day..end_time.end_of_day) }

  validates :event_type, :occurred_at, :user_id, presence: true
  validate :previous_event_is_check_in, if: :check_out?, on: :create
  validate :previous_event_is_check_out, if: :check_in?, on: :create
  validate :event_time_between_office_hours, :occurred_at_cannot_be_in_the_future, unless: -> { occurred_at.blank? }

  def occurred_at_cannot_be_in_the_future
    return if occurred_at < Time.current

    errors.add(:occurred_at, "can't be in the future")
  end  

  def previous_event_is_check_in
    return if previous_event&.check_in?

    errors.add(:event_type, 'need to check in first')
  end

  def previous_event_is_check_out
    return if (previous_event.nil? || previous_event.check_out?)

    errors.add(:event_type, 'need to check out first')
  end

  def event_time_between_office_hours
    return if occurred_at.hour.between?(6, 19)

    errors.add(:occurred_at, 'event time should be between office hours')
  end

  def next_event
    @_next_event ||= user&.events&.events_of_day(occurred_at)&.where('occurred_at > ?', occurred_at)&.last
  end

  def previous_event
    @_previous_event ||= user&.events&.events_of_day(occurred_at)&.where('occurred_at < ?', occurred_at)&.first
  end
end
