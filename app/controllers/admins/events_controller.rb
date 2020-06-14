module Admins
  class EventsController < BaseController
    def index
      @start_date, @end_date = params[:daterange]&.split(' - ')&.map{|date| Date.parse(date) }
      @start_date ||= Date.current.beginning_of_week
      @end_date ||= Date.current
      @presenter = EventsPresenter.new(user, @start_date, @end_date)
    end

    def new
      @event = user.events.build
    end

    def create
      @event = user.events.build(event_params)
      if @event.save
        redirect_to admins_user_events_path(user)
      else
        render :new
      end
    end

    def edit
      event
    end

    def update
      if event.update(update_event_params)
        redirect_to admins_user_events_path(user)
      else
        render :edit
      end
    end

    def destroy
      event.destroy
      redirect_to admins_user_events_path(user)
    end

    private 
    
    def user
      @user ||= User.find(params[:user_id])
    end

    def event
      @event ||= user.events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:occurred_at, :event_type)
    end

    def update_event_params
      params.require(:event).permit(:occurred_at)
    end
  end
end
