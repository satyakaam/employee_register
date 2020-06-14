class EventsPresenter
  def initialize(user, start_date = Date.current.beginning_of_week, end_date = Date.current)
    @user = user
    @events = user.events.filter_by_dates(start_date, end_date)
  end

  def time_sheet
    time_sheet = Hash.new
    @events.group_by {|e| e.occurred_at.to_date }.each do |key, events|
      time_sheet[key] = {
        error: events.length.odd? || events.select(&:auto_generated).any?,
        check_ins: events.select(&:check_in?),
        check_outs: events.select(&:check_out?)
      }
    end
    time_sheet
  end
end
