class EventsController < ApplicationController
  def index
    @start_date, @end_date = params[:daterange]&.split(' - ')&.map{|date| Date.parse(date) }
    @start_date ||= Date.current.beginning_of_week
    @end_date ||= Date.current
    @presenter = EventsPresenter.new(current_user, @start_date, @end_date)
  end

  def create
    saved = current_user.checked_in? ? current_user.check_out : current_user.check_in
    flash[:error] = "Please try within office hours." unless saved

    redirect_to root_path
  end
end
