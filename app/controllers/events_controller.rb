class EventsController < ApplicationController

skip_before_action :authenticate, only: :show


  def index
    @events = Event.all

    logger.debug "-----------------------"
    logger.debug "#{@events}"
    logger.debug "-----------------------"
    events = []
    @each_event = @events.each do
                      events << _1.name
                  end
    @event_names = events
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      logger.debug "-----params------"
      logger.debug "#{params}"
      logger.debug "-----params------"
      redirect_to @event, notice: "Created"
    end
  end
  
  def show
    @event = Event.find(params[:id]) 
    @tickets = @event.tickets.includes(:user).order(:created_at)  # if we don't use include, @ticketsの要素の数だけクエリが作成される
  end


  def edit
    @event = current_user.created_events.find(params[:id]) # only person who create event can edit by current_user.created_events
  end

  def update
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Event has updated!"
    end
  end

  def destroy
    @event = current_user.created_events.find(params[:id])

    @event.destroy!
    redirect_to root_path, notice: "Event has deleted!"
  end

  private
  
  def event_params
    params.require(:event).permit(:name, :place, :content, :start_at, :end_at)
  end
end
